#!/bin/bash
# ============================================
# 🖥️  SERVER MONITOR & NETWORK ALERT SYSTEM
# ============================================

# === CONFIGURAZIONE BASE ===
TELEGRAM_TOKEN="INSERISCI QUI IL TUO TOKEN TELEGRAM"
CHAT_ID="INSERISCI QUI IL TUO CHAT ID"
NAS_PATH="/media/utente/HDD_NAS"
LOG_FILE="/home/utente/SCRIPT_REPORT_SERVER/server_report.log"

# === PARAMETRI DI ALLERTA ===
CPU_THRESHOLD=85
DISK_THRESHOLD=90
RAM_THRESHOLD=90

# === ICONOGRAFIA ===
OK_ICON="✅"
WARN_ICON="⚠️"
ALERT_ICON="🔥"
DISK_ICON="💾"
CPU_ICON="🧠"
RAM_ICON="📊"
DOCKER_ICON="🐳"
TEMP_ICON="🌡️"

# ============================================
# 🔹 FUNZIONI TELEGRAM
# ============================================

send_telegram_message() {
  local text="$1"
  curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_TOKEN/sendMessage" \
    -d chat_id="$CHAT_ID" \
    -d parse_mode="Markdown" \
    -d text="$text" > /dev/null
}

# ============================================
# 🔹 FUNZIONI DI SISTEMA
# ============================================

get_cpu_usage() {
  top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}'
}

get_ram_usage() {
  free | awk '/Mem:/ {printf("%.0f", $3/$2 * 100)}'
}

# === DISCO E NAS ===
get_disk_usage_percent() {
  local mount_point="$1"
  df "$mount_point" | awk 'NR==2 {print $5}' | tr -d '%'
}

get_disk_free_gb() {
  local mount_point="$1"
  df -BG "$mount_point" | awk 'NR==2 {print $4}'
}

get_cpu_temp() {
  if command -v sensors >/dev/null 2>&1; then
    sensors | awk '/Package id 0:/ {print $4}' | head -n1
  else
    echo "N/A"
  fi
}

get_smart_data() {
  local disks=("/dev/sda" "/dev/sdb")
  local result=""
  for disk in "${disks[@]}"; do
    if [ -b "$disk" ]; then
      output=$(smartctl -H "$disk" 2>/dev/null)
      if [[ -n "$output" ]]; then
        health=$(echo "$output" | grep -E "SMART overall-health|Overall health" | sed "s/^/    /")
        if [[ -z "$health" ]]; then
          health="    Stato SMART non disponibile"
        fi
        result+="  🔹 $disk — $(echo $health | sed 's/.*: //')\n"
      else
        result+="  🔹 $disk — Non leggibile (permessi insufficienti o disco assente)\n"
      fi
    fi
  done
  echo -e "$result"
}

get_top_cpu_processes() {
  ps -eo comm,%cpu --sort=-%cpu | awk 'NR>1 && NR<=6 {printf "  🔺 *%s* — %s %%\n", $1, $2}'
}

get_top_ram_processes() {
  ps -eo comm,%mem --sort=-%mem | awk 'NR>1 && NR<=6 {printf "  💧 *%s* — %s %%\n", $1, $2}'
}

get_docker_status() {
  if command -v /usr/bin/docker >/dev/null 2>&1; then
    local msg=""
    while read -r name status; do
      [[ "$name" == "NAMES" ]] && continue
      if [[ "$status" == *"Up"* ]]; then
        msg+=$(printf "  🟢 *%s* — ✅ Online%%0A" "$name")
      else
        msg+=$(printf "  🔴 *%s* — 🔥 Offline%%0A" "$name")
      fi
    done < <(/usr/bin/docker ps -a --format "table {{.Names}}\t{{.Status}}")
    printf "%s" "$msg"
  else
    echo "Docker non installato o non in esecuzione."
  fi
}

# ============================================
# 🔹 FUNZIONE DI REPORT
# ============================================

send_report() {
  local cpu ram disk_percent disk_free nas_percent nas_free cpu_temp smart docker_section cpu_alert ram_alert disk_alert

  cpu=$(get_cpu_usage)
  ram=$(get_ram_usage)
  disk_percent=$(get_disk_usage_percent "/")
  disk_free=$(get_disk_free_gb "/")
  nas_percent=$(get_disk_usage_percent "$NAS_PATH")
  nas_free=$(get_disk_free_gb "$NAS_PATH")
  cpu_temp=$(get_cpu_temp)
  smart=$(get_smart_data)
  docker_section=$(get_docker_status)

  # ==== CHECK ALERT ====
  cpu_alert=""
  ram_alert=""
  disk_alert=""
  (( cpu > CPU_THRESHOLD )) && cpu_alert="$ALERT_ICON" || cpu_alert=""
  (( ram > RAM_THRESHOLD )) && ram_alert="$WARN_ICON" || ram_alert=""
  (( disk_percent > DISK_THRESHOLD )) && disk_alert="$WARN_ICON" || disk_alert=""

  # ==== MESSAGGIO TELEGRAM ====
  local msg=""
  msg+=$(printf "*📊 SERVER REPORT PERIODICO 📊*%%0A")
  msg+=$(printf "_%s_%%0A%%0A" "$(date '+%d/%m/%Y %H:%M:%S')")

  msg+=$(printf "%s *CPU:* %s %% %s%%0A" "$CPU_ICON" "$cpu" "$cpu_alert")
  msg+=$(printf "%s *CPU Temp:* %s%%0A" "$TEMP_ICON" "$cpu_temp")

  msg+=$(printf "%s *RAM:* %s %% %s%%0A" "$RAM_ICON" "$ram" "$ram_alert")
  msg+=$(printf "%s *Disco (OS):* %s %% — %s rimanenti %s%%0A" "$DISK_ICON" "$disk_percent" "$disk_free" "$disk_alert")
  msg+=$(printf "%s *Disco NAS:* %s %% — %s rimanenti %s%%0A" "$DISK_ICON" "$nas_percent" "$nas_free" "$disk_alert")

  msg+=$(printf "%%0A🧩 *TOP 5 PROCESSI PER UTILIZZO RISORSE* %%0A%%0A")
  msg+=$(printf "🔥 *CPU:*%%0A%s%%0A" "$(get_top_cpu_processes)")
  msg+=$(printf "💧 *RAM:*%%0A%s%%0A" "$(get_top_ram_processes)")

  msg+=$(printf "%%0A%s *SMART Status Dischi:*%%0A%s%%0A" "$DISK_ICON" "$smart")

  msg+=$(printf "%%0A%s *DOCKER CONTAINERS* %%0A" "$DOCKER_ICON")
  msg+="$docker_section"

  # ==== LOG SU FILE ====
  echo "$(date '+%d/%m/%Y %H:%M:%S') | CPU: $cpu % $cpu_alert | RAM: $ram % $ram_alert | Disco OS: $disk_percent % $disk_alert | NAS: $nas_percent % $disk_alert | CPU Temp: $cpu_temp" >> "$LOG_FILE"

  send_telegram_message "$msg"
}

send_report

