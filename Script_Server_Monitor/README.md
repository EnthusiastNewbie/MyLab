# 🖥️ Guida Completa al Server Monitor & Network Alert System

## 🔹 Introduzione
Questa guida spiega passo passo come configurare **uno script Bash per il monitoraggio del server e l'invio di alert via Telegram**.  
Perfetta per chi gestisce un piccolo **server domestico, NAS o VPS**, e vuole ricevere notifiche automatiche sullo stato del sistema.

---

## 1️⃣ Creazione del Bot Telegram

Per ricevere gli alert su Telegram, bisogna prima creare un bot.

1. Apri Telegram e cerca **@BotFather**
2. Invia il comando:
   ```bash
   /newbot
   ```
3. Segui le istruzioni:
   - Dai un nome al bot (es: `ServerMonitorBot`)
   - Scegli uno username unico (es: `server_monitor_bot`)
4. Al termine, BotFather fornirà un **Token API** simile a:
   ```
   123456789:AAHNy-Vbyl6y7-XhrJ30XA61fs8HDX003Ng
   ```
   Salvalo: servirà nello script.
5. Recupera il tuo Chat ID:
   - Avvia una chat con il bot (clicca su “Start”)
   - Apri nel browser:
     ```
     https://api.telegram.org/bot<IL_TUO_TOKEN>/getUpdates
     ```
   - Trova `"chat":{"id":...}` → quello è il tuo Chat ID.

---

## 2️⃣ Salvataggio e Permessi dello Script

1. Crea la cartella per gli script:
   ```bash
   mkdir -p /home/utente/SCRIPT_REPORT_SERVER
   ```
2. Salva lo script nel file:
   ```bash
   /home/utente/SCRIPT_REPORT_SERVER/server_monitor.sh
   ```
3. Rendi lo script eseguibile:
   ```bash
   chmod +x /home/utente/SCRIPT_REPORT_SERVER/server_monitor.sh
   ```
4. Imposta le variabili principali nello script:

   ```bash
   TELEGRAM_TOKEN="IL_TUO_TOKEN"
   CHAT_ID="IL_TUO_CHAT_ID"
   NAS_PATH="/PATH/DEL/NAS/"
   LOG_FILE="/home/utente/SCRIPT_REPORT_SERVER/server_report.log"
   CPU_THRESHOLD=85
   RAM_THRESHOLD=90
   DISK_THRESHOLD=90
   ```

---

## 3️⃣ Installazione delle Dipendenze

Lo script richiede alcuni pacchetti per funzionare correttamente:

```bash
sudo apt update
sudo apt install -y curl smartmontools lm-sensors docker.io
```

- `curl` → invia messaggi su Telegram  
- `smartmontools` → verifica lo stato SMART dei dischi  
- `lm-sensors` → mostra la temperatura della CPU  
- `docker.io` → (opzionale) per monitorare container Docker

Configura i sensori hardware:
```bash
sudo sensors-detect
```
Rispondi **yes** a tutte le domande.

---

## 4️⃣ Permessi per SMART

Per leggere lo stato SMART serve **root**. Hai due opzioni:

**Opzione 1:** usare `sudo` nello script
```bash
output=$(sudo smartctl -H "$disk" 2>/dev/null)
```

**Opzione 2:** consentire `sudo` senza password per `smartctl`
```bash
sudo visudo
```
Aggiungi questa riga:
```
utente ALL=(ALL) NOPASSWD: /usr/sbin/smartctl
```

---

## 5️⃣ Test dello Script

Esegui manualmente:
```bash
/home/utente/SCRIPT_REPORT_SERVER/server_monitor.sh
```

Controlla:
- se ricevi un messaggio su Telegram ✅  
- se il log viene scritto correttamente:
  ```bash
  cat /home/utente/SCRIPT_REPORT_SERVER/server_report.log
  ```

Se non arrivano messaggi, verifica **Token** e **Chat ID**.

---

## 6️⃣ Automatizzazione con Crontab

Per avere report automatici, aggiungi una pianificazione al crontab di root:

```bash
sudo crontab -e
```

E inserisci:
```
0 * * * * /home/utente/SCRIPT_REPORT_SERVER/server_monitor.sh
```

Esempi di frequenza:
- Ogni 30 minuti → `*/30 * * * *`
- Ogni giorno alle 8 → `0 8 * * *`

Usa il crontab di **root** se vuoi leggere SMART.

---

## 7️⃣ Come Funzionano gli Alert

Lo script confronta i valori reali con le soglie configurate:

| Parametro | Soglia Default | Emoji | Significato |
|------------|----------------|--------|--------------|
| CPU        | 85%            | 🔥     | Sovraccarico |
| RAM        | 90%            | ⚠️     | Alta memoria |
| Disco OS   | 90%            | ⚠️     | Quasi pieno  |
| Disco NAS  | 90%            | ⚠️     | Quasi pieno  |

---

## 8️⃣ Log e Manutenzione

- Log giornaliero:  
  `/home/utente/SCRIPT_REPORT_SERVER/server_report.log`
- Controllo rapido:
  ```bash
  less /home/utente/SCRIPT_REPORT_SERVER/server_report.log
  ```
- Test alert immediati:
  ```bash
  CPU_THRESHOLD=1
  RAM_THRESHOLD=1
  DISK_THRESHOLD=1
  /home/utente/SCRIPT_REPORT_SERVER/server_monitor.sh
  ```

---

## 9️⃣ Monitoraggio Docker

Lo script mostra lo stato dei container Docker:
- 🟢 Online  
- 🔴 Offline  

Se non vuoi monitorare Docker, commenta la funzione `get_docker_status` nello script.

---

> 💡 **Autore:** Enthusiast Newbie  
> Blog: [https://enthusiastnewbie.xyz](https://enthusiastnewbie.xyz)
