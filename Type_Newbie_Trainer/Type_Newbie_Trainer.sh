#!/bin/bash

# ==========================================
# TYPE NEWBIE TRAINER - By Enthusiast Newbie
# ==========================================

# --- CONFIGURAZIONE FILE ESTERNI ---
FILE_FRASI="frasi.txt"
FILE_SCORE=".highscore"

# Controllo se il file delle frasi esiste
if [ ! -f "$FILE_FRASI" ]; then
    echo "Il terminale è il miglior amico di un Enthusiast Newbie." > "$FILE_FRASI"
    echo "Bash permette di automatizzare compiti complessi con poche righe di codice." >> "$FILE_FRASI"
fi

# Inizializza l'High Score se non esiste
if [ ! -f "$FILE_SCORE" ]; then
    echo "0" > "$FILE_SCORE"
fi

# --- COLORI  ---
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[1;34m'
PURPLE='\033[0;35m'
DIM='\033[2m'
NC='\033[0m' # No Color
BOLD='\033[1m'
UNDERLINE='\033[4m'

# --- FUNZIONE PROGRESS BAR ---
disegna_barra() {
    local attuale=$1
    local totale=$2
    local larghezza=40
    local progresso=$(( (attuale * larghezza) / totale ))
    local barra=""
    
    for ((p=0; p<larghezza; p++)); do
        if [ $p -lt $progresso ]; then
            barra+="█"
        else
            barra+="░"
        fi
    done
    echo -e "${PURPLE}[${barra}] $(( (attuale * 100) / totale ))%${NC}"
}

# --- FUNZIONE PRINCIPALE DI DIGITAZIONE ---
avvia_sessione() {
    # Legge il record attuale
    HIGH_SCORE=$(cat "$FILE_SCORE")
    
    # Seleziona una frase casuale
    TARGET=$(shuf -n 1 "$FILE_FRASI")
    LENGTH=${#TARGET}
    
    USER_INPUT=()
    INDEX=0

    BOLD='\033[1m'
    UNDERLINE='\033[4m'

    clear
    echo -e "${PURPLE}=======================================${NC}"
    echo -e "  ⚡ ${BOLD}TYPE NEWBIE TRAINER${NC} ⚡ "
    echo ""
    echo -e "   RECORD ATTUALE: ${GREEN}${BOLD}$HIGH_SCORE WPM${NC}"
    echo -e "${PURPLE}=======================================${NC}"
    echo ""
    echo -e "${BLUE}Trascrivi (premi ESC per uscire):${NC}"
    echo -e "${DIM}$TARGET${NC}\n"
    
    # Salviamo la posizione iniziale per la progress bar e l'input
    echo -ne "\033[s"

    START_TIME=$(date +%s)

    while [ $INDEX -lt $LENGTH ]; do
        # 1. Calcolo e disegno della progress bar nel buffer
        # Ripristiniamo il cursore all'inizio dell'area dinamica
        BUFFER="\033[u"
        
        # Aggiungiamo la barra al buffer
        BARRA_STR=$(disegna_barra $INDEX $LENGTH)
        BUFFER+="$BARRA_STR\n\n"

        # 2. Costruzione della stringa digitata con i colori
        for (( i=0; i<$INDEX; i++ )); do
            EXPECTED="${TARGET:$i:1}"
            TYPED="${USER_INPUT[$i]}"

            if [ "$TYPED" == "$EXPECTED" ]; then
                BUFFER+="${GREEN}${TYPED}${NC}"
            else
                if [ "$TYPED" == " " ]; then
                    BUFFER+="${RED}_${NC}"
                else
                    BUFFER+="${RED}${TYPED}${NC}"
                fi
            fi
        done
        
        # 3. Output a video 
        echo -ne "$BUFFER"

        # Lettura del tasto
        IFS= read -r -n 1 -s char

        if [[ $char == $'\e' ]]; then
            echo -e "\n\nUscita forzata. Allenamento annullato!"
            return 1
        fi

        if [[ $char == $'\177' || $char == $'\b' ]]; then
            if [ $INDEX -gt 0 ]; then
                INDEX=$((INDEX - 1))
                unset 'USER_INPUT[$INDEX]'
            fi
        else
            USER_INPUT[$INDEX]=$char
            INDEX=$((INDEX + 1))
        fi
    done

    # Mostra l'ultimo stato (100%) prima di chiudere
    echo -ne "\033[u$(disegna_barra $LENGTH $LENGTH)"
    
    END_TIME=$(date +%s)
    
    # --- CALCOLO STATISTICHE ---
    DURATA=$((END_TIME - START_TIME))
    if [ $DURATA -eq 0 ]; then DURATA=1; fi

    WPM=$(( (LENGTH * 12) / DURATA ))

    ERRORI=0
    for (( i=0; i<$LENGTH; i++ )); do
        if [ "${USER_INPUT[$i]}" != "${TARGET:$i:1}" ]; then
            ERRORI=$((ERRORI + 1))
        fi
    done
    
    ACCURACY=$(( 100 - ((ERRORI * 100) / LENGTH) ))

    echo -e "\n"
    echo -e "\n"
    echo -e "\n\n----------------------------------------"
    echo -e "✅ Esercizio completato!"
    echo -e "⏱️  Tempo: ${DURATA} secondi"
    echo -e "🚀 Velocità: ${WPM} WPM"
    echo -e "🎯 Precisione: ${ACCURACY}% ($ERRORI errori)"
    
    # Controllo High Score
    if [ $WPM -gt $HIGH_SCORE ]; then
        echo -e "${PURPLE}🏆 NUOVO RECORD PERSONALE!${NC}"
        echo "$WPM" > "$FILE_SCORE"
    fi
    echo "----------------------------------------"
    return 0
}

# --- LOOP DEL PROGRAMMA ---
while true; do
    avvia_sessione
    if [ $? -eq 1 ]; then break; fi
    
    echo -n "Vuoi fare un'altra esercitazione? (s/n): "
    read -n 1 -s risposta
    echo ""
    
    if [[ "$risposta" != "s" && "$risposta" != "S" ]]; then
        echo "Grazie per esserti allenato! Alla prossima."
        break
    fi
done