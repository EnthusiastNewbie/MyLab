#!/bin/bash

# Funzione per mostrare il menu 
#Cosa fa: Abbiamo racchiuso tutti i comandi echo (che stampano il testo a video) dentro un "contenitore" chiamato mostra_menu.
#Il comando clear: Pulisce il terminale. 
#Ogni volta che il menu viene ricaricato, cancella tutto il testo precedente, dando l'illusione di un programma "fisso" sullo schermo, invece di una lista infinita di testo che scorre.
#Le Funzioni. Invece di riscrivere quelle 10 righe di echo ogni volta che vogliamo mostrare il menu, ci basta scrivere mostra_menu. Rende il codice pulito e modulare.
mostra_menu() {
    clear
    echo "========================================="
    echo "   ENTHUSIAST NEWBIE SYSTEM MANAGER v1.0 "
    echo "========================================="
    echo "1. Mostra informazioni sistema (RAM/Disco)"
    echo "2. Aggiorna il sistema"
    echo "3. Crea un nuovo utente"
    echo "4. Pulisci cache pacchetti"
    echo "0. Esci"
    echo "========================================="
}

# Ciclo infinito
#while true significa "Finché la condizione è Vera". Poiché "true" è sempre vero, questo ciclo non finisce mai da solo.
# Continuerà a girare all'infinito tra do e done.

Perché lo usiamo: Senza questo ciclo, lanceresti lo script, sceglieresti l'opzione "1", lo script ti mostrerebbe le info e poi... si chiuderebbe. Noi vogliamo che dopo aver eseguito l'azione, ti mostri di nuovo il menu per fare altro.
while true; do
    mostra_menu
    read -p "Scegli un'opzione [0-4]: " scelta

    case $scelta in
        1)
            echo "Hai scelto Info Sistema..."
            # Qui metterai i tuoi comandi
            sleep 2
            ;;
        2)
            echo "Hai scelto Aggiornamento..."
            # Qui metterai i comandi apt/dnf
            sleep 2
            ;;
        3)
            echo "Hai scelto Creazione Utente..."
            # Qui userai useradd
            sleep 2
            ;;
        4)
            echo "Hai scelto Pulizia..."
            # Qui userai apt clean etc
            sleep 2
            ;;
        0)
            echo "Uscita... Ciao!"
            break
            ;;
        *)
            echo "Opzione non valida, riprova."
            sleep 1
            ;;
    esac
    
    echo "Premi Invio per tornare al menu..."
    read # Aspetta che l'utente prema invio
done