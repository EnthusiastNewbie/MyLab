#!/bin/bash

# ==========================================
#  🏰 THE BASH DUNGEON 🏰
# ==========================================

# 1. SETUP INIZIALE
HP_GIOCATORE=50
HP_MOSTRO=50
POZIONI=3
TURNO=1

# --- FUNZIONI SONORE (Audio FX) ---
# echo -e "\a" emette il suono di sistema (Bell)
# L'opzione -n serve a non andare a capo
fx_colpo() {
    echo -e -n "\a"
}

fx_vittoria() {
    # Una piccola fanfara: Beep-Beep-BEEP!
    echo -e -n "\a"; sleep 0.2
    echo -e -n "\a"; sleep 0.2
    echo -e -n "\a"
}

fx_gameover() {
    # Due beep lenti tristi
    echo -e -n "\a"; sleep 0.5
    echo -e -n "\a"
}
# ----------------------------------

clear
echo "=============================================="
echo "      🏰  BENVENUTO NEL BASH DUNGEON  🏰      "
echo "=============================================="
echo " 👹 Un terribile MOSTRO BUG ti sbarra la strada!"
echo "=============================================="
fx_colpo # Suono di avvio
sleep 2

read -p "INSERISCI IL TUO NOME GIOCATORE : " PLAYER

# 2. GAME LOOP
while [[ $HP_GIOCATORE -gt 0 && $HP_MOSTRO -gt 0 ]] ; do

    # Intestazione Turno Grafica
    echo ""
    echo "🕐 --- TURNO $TURNO ---"
    
    # Barra della vita visiva
    echo "👤 "$PLAYER": $HP_GIOCATORE HP ❤️    |   🎒 ZAINO: $POZIONI 🧪"
    echo "👾 BUG:  $HP_MOSTRO HP 💚"
    echo "----------------------------------------------"
    
    # Menu visivo
    echo "Cosa vuoi fare?"
    echo "  🗡️  [1] Attacca"
    echo "  ✨  [2] Cura"
    echo "  🏃  [3] Scappa"
    echo "----------------------------------------------"
    read -p "👉 Scegli (1-3): " MOSSA

    echo "" 

    case $MOSSA in 
       1) 
          echo "⚔️  SBAMM! Hai attaccato il Bug!"
          HP_MOSTRO=$(($HP_MOSTRO - 15))
          fx_colpo # SUONO
          ;;

       2) 
          if [ $POZIONI -gt 0 ] ;then
              echo "✨ Glup glup... Ti sei bevuto una pozione!"
              HP_GIOCATORE=$(($HP_GIOCATORE + 5))
              POZIONI=$(($POZIONI - 1))
              # Suono di "ricarica" (due beep veloci)
              echo -e -n "\a"; sleep 0.1; echo -e -n "\a"
          else 
              echo "❌ ZAINO VUOTO! Non hai più pozioni 🧪"
              fx_gameover # Suono errore
          fi
          ;;

       3) 
          echo "🏃 Te la dai a gambe levate... ADDIO!"
          exit 1
          ;;
       
       *) # Default
          echo "❓ Confuso? Perdi il turno!"
          ;;
    esac

    # CONTROLLO VITTORIA RAPIDO
    if [ $HP_MOSTRO -le 0 ] ; then
        break
    fi

    # TURNO DEL NEMICO
    echo "..."
    sleep 1
    echo "🔥 Il Bug risponde all'attacco!"
    
    DANNO=$((RANDOM % 16))
    HP_GIOCATORE=$(($HP_GIOCATORE - $DANNO))
    
    echo "💥 BOOM! Ti ha inflitto $DANNO danni!"
    fx_colpo # SUONO DANNO SUBITO
    
    ((TURNO++))
    sleep 1

done

# 5. FINE DEL GIOCO
echo ""
echo "=============================================="
if [[ $HP_GIOCATORE -le 0 ]] ; then
    fx_gameover # SUONO TRISTE
    echo "💀 GAME OVER... Il Bug ha crashato il sistema."
    echo "   Riprova sarai più fortunato!"
else 
    fx_vittoria # FANFARA DI VITTORIA! 🎵
    echo "🏆 VITTORIA LEGGENDARIA.. complimenti "$PLAYER" !"
    echo "   Hai sconfitto il Bug in $TURNO turni."
    
    # SALVATAGGIO LOG
    DATA=$(date "+%d/%m/%Y %H:%M")
    LEADERBOARD="./score.txt"
    
    if [ -e "$LEADERBOARD" ]; then
        echo " "$PLAYER" 🏆 WIN - Turni: $TURNO - Data: $DATA" >> "$LEADERBOARD"
    else 
        touch "score.txt"
        echo " "$PLAYER" 🏆 WIN - Turni: $TURNO - Data: $DATA" >> "$LEADERBOARD"
    fi
    echo "💾 Punteggio salvato nella Hall of Fame (score.txt)"
fi
echo "=============================================="