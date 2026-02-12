#!/bin/bash

# --- CONFIGURAZIONE FILE ESTERNO ---
FILE_FRASI="frasi.txt"

# Controllo se il file delle frasi esiste, altrimenti ne creo uno di esempio
if [ ! -f "$FILE_FRASI" ]; then
    echo "Il terminale e il miglior amico di un Enthusiast Newbie." > "$FILE_FRASI"
    echo "Bash permette di automatizzare compiti complessi con poche righe di codice." >> "$FILE_FRASI"
fi

# Colori ANSI
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[1;34m'
NC='\033[0m' 

# --- FUNZIONE PRINCIPALE DI DIGITAZIONE ---
avvia_sessione() {
    # Seleziona una frase casuale dal file usando 'shuf'
    TARGET=$(shuf -n 1 "$FILE_FRASI")
    INDEX=0
    LENGTH=${#TARGET}

    clear
    echo "========================================"
    echo "      TYPE NEWBIE TRAINER               "
    echo "========================================"
    echo -e "${BLUE}Trascrivi:"
    echo -e "${NC}$TARGET"
    echo -e "${BLUE}Inizia a scrivere...\n"

    # Registriamo il tempo di inizio in secondi
    START_TIME=$(date +%s)

    while [ $INDEX -lt $LENGTH ]; do
        IFS= read -r -n 1 -s char

        # Gestione Backspace
        if [[ $char == $'\177' ]]; then
            if [ $INDEX -gt 0 ]; then
                INDEX=$((INDEX - 1))
                echo -ne "\b \b"
            fi
            continue
        fi

        EXPECTED="${TARGET:$INDEX:1}"

        if [ "$char" == "$EXPECTED" ]; then
            echo -ne "${GREEN}${char}${NC}"
        else
            echo -ne "${RED}${char:-_}${NC}" 
        fi

        INDEX=$((INDEX + 1))
    done

    # Registriamo il tempo di fine
    END_TIME=$(date +%s)
    
    # --- CALCOLO STATISTICHE ---
    DURATA=$((END_TIME - START_TIME))
    
    # Per evitare errori di divisione per zero se la frase è istantanea
    if [ $DURATA -eq 0 ]; then DURATA=1; fi

    # Calcolo WPM (Parole al Minuto)
    # Formula standard: (Caratteri / 5) / (Tempo in minuti)
    # In Bash usiamo: (Caratteri * 12) / Tempo in secondi
    WPM=$(( (LENGTH * 12) / DURATA ))

    echo -e "\n\n----------------------------------------"
    echo -e "✅ Esercizio completato!"
    echo -e "⏱️  Tempo: ${DURATA} secondi"
    echo -e "🚀 Velocità: ${WPM} WPM (Parole al minuto)"
    echo "----------------------------------------"
}

# --- LOOP DEL PROGRAMMA ---
while true; do
    avvia_sessione
    
    echo -n "Vuoi fare un'altra esercitazione? (s/n): "
    read -n 1 risposta
    echo ""
    
    if [[ "$risposta" != "s" && "$risposta" != "S" ]]; then
        echo "Grazie per esserti allenato! Alla prossima, Newbie."
        break
    fi
done