#!/bin/bash

# Funzione per mostrare il menu 
# Cosa fa: Abbiamo racchiuso tutti i comandi echo (che stampano il testo a video) dentro un "contenitore" chiamato mostra_menu.
# Il comando clear: Pulisce il terminale. 
# Ogni volta che il menu viene ricaricato, cancella tutto il testo precedente, dando l'illusione di un programma "fisso" sullo schermo, 
# invece di una lista infinita di testo che scorre.
# Le Funzioni. Invece di riscrivere quelle 10 righe di echo ogni volta che vogliamo mostrare il menu, ci basta scrivere mostra_menu. 

mostra_menu() {
    clear
    echo "========================================="
    echo "   ENTHUSIAST NEWBIE SYSTEM MANAGER v1.0 "
    echo "========================================="
    echo ""
    echo "1. Mostra INFO sul sistema"
    echo "2. AGGIORNA il sistema"
    echo "3. Crea un nuovo UTENTE"
    echo "4. Pulisci CACHE pacchetti"
    echo "5. Info NETWORK"
    echo "6. Cerca Directory PESANTI"
    echo "0. Esci"
    echo "========================================="
}

# Ciclo infinito
# while true significa "Finché la condizione è Vera". Poiché "true" è sempre vero, questo ciclo non finisce mai da solo.
# Continuerà a girare all'infinito tra do e done.
# Senza questo ciclo, lanceresti lo script, sceglieresti l'opzione "1", lo script ti mostrerebbe le info e poi... si chiuderebbe.
# Noi vogliamo che dopo aver eseguito l'azione, ti mostri di nuovo il menu per fare altro.

while true; do
    mostra_menu
    read -p "Scegli un'opzione [0-6]: " scelta 

    case $scelta in 
        1)
            echo "--- INFO SISTEMA ---"
            echo "Raccolta dati in corso..."
            
            # Raccolta Dati
            KERNEL=$(uname -r)
            # awk -F= usa l'uguale come separatore per leggere os-release
            OS=$(awk -F= 'NR==1{print $2}' /etc/os-release)  
            # Nota: uso -F: per pulire meglio il nome CPU
            # xargs elimina gli spazi
            CPU=$(lscpu | grep "Model name" | awk -F: '{print $2}'|xargs)
            DISK=$(df -h / | awk 'NR==2 {print $4}')
            RAM=$(free -h | awk 'NR==2 {print $4}') 

            echo ""
            echo "🖥️  OS: $OS"
            echo "⚙️  KERNEL: $KERNEL"
            echo "🧠 CPU: $CPU"
            echo "💾 DISCO (Libero): $DISK"
            echo "⚡ RAM (Usata): $RAM"
            echo ""
            sleep 3
            ;;
        2)
            echo "--- AGGIORNAMENTO SISTEMA ---"
            echo "Richiedo permessi di root per aggiornare..."
            sleep 1
            # && assicura che l'upgrade parta solo se l'update va a buon fine
            sudo apt update && sudo apt upgrade
            echo "✅ SISTEMA AGGIORNATO"
            sleep 2
            ;;
        3)
            echo "--- CREAZIONE NUOVO UTENTE ---"
            echo "Utenti umani già presenti (con shell Bash):"
            echo "-------------------------------------------"
            # Uso grep per filtrare e awk per formattare
            USERS=$(grep "/bin/bash" /etc/passwd | awk -F: '{print "👤 " $1}')
            # Nota: Ho tolto 'cat'. Puoi dare il file direttamente a grep! È più efficiente.
            
            # USO LE VIRGOLETTE per stampare la lista in verticale
            echo "$USERS"
            echo "-------------------------------------------"
            
            read -p "Inserisci il nome del NUOVO utente: " utente
            
            if [ -z "$utente" ]; then
                echo "❌ Errore: Nome utente non inserito."
            else
                echo "Lancio la procedura guidata per $utente..."
                sleep 1
                # adduser gestisce home, gruppi e password
                sudo adduser "$utente"
            fi
            sleep 2
            ;;
        4)
            echo "--- PULIZIA SISTEMA ---"
            echo "Rimuovo pacchetti orfani e cache..."
            sudo apt autoclean && sudo apt autoremove
            echo "✅ SISTEMA RIPULITO"
            sleep 2
            ;;

        5)  echo "--- INFO NETWORK ---"
            sleep 1
            echo "Raccolgo Informazioni sulla rete..."
            # 1. Trovo l'interfaccia principale (escludo 'lo' che è il loopback)
            # awk -F: pulisce i due punti finali (eth0: -> eth0)
            INTERFACCIA=$(ip a | grep "state UP" |awk -F: '{print $2}')
            IPADDRESS=$(ip a | grep "inet" |grep -v "inet6"|grep -v "127.0.0" |awk '{print $2}')
            
            echo " INTERFACCIA $INTERFACCIA "
            echo " IP LOCALE $IPADDRESS"
            echo " Controllo la Connessione a Internet...provo a contattate i server Google"
            sleep 2

            #Le parentesi quadre [ ... ] servono per confrontare cose (numeri, stringhe). L'if serve per eseguire comandi.
            #Quando usi un comando come ping, grep o mkdir dentro un if, le parentesi NON ci vanno. 
            if ping -c3 google.com; 
            then
                    echo "CONNESSIONE a Internet ATTIVA"
            else
                    echo "CONNESSIONE a Internet DISATTIVA"
            
            fi
            ;;
            
        6) 
           echo "--- CACCIATORE DI SPAZIO ---"
           echo "Dove vuoi cercare le cartelle più pesanti?"
           # Uso -n 1 così non devi premere INVIO dopo la lettera! (Topic 103.1)
           read -p "[H]ome utente / [A]ll system / [Z] Annulla: " -n 1 opzione
           echo "" # Serve un a capo estetico dopo il read -n 1

           case $opzione in 
               h|H) # Accetto sia h minuscola che H maiuscola
                    echo "🔍 Analisi della Home ($HOME) in corso..."
                    echo "Le 10 cartelle più pesanti:"
                    echo "---------------------------"
                    # Uso $HOME invece del nome fisso
                    # 2>/dev/null nasconde errori di lettura
                    du -h "$HOME" 2>/dev/null | sort -rh | head -n 10
                    ;;

               a|A) 
                    echo "🔍 Analisi dell'intero sistema / (Richiede tempo)..."
                    echo "⚠️  Ignoro gli errori di permesso."
                    echo "---------------------------"
                    du -h / 2>/dev/null | sort -rh | head -n 10
                    ;;

                z|Z) 
                    echo "Annullato. Torno al menu..."
                    # Non serve break, esce dal case e torna al while
                    ;;

                *) 
                    echo "❌ Scelta non valida."
                    ;;
            esac
            sleep 3
            ;;
           


            
        0)
            echo "Uscita... Alla prossima!"
            break
            ;;
        *)
            echo "❌ Opzione non valida, riprova."
            sleep 1
            ;;
    esac
    
    echo ""
    echo "Premi [INVIO] per tornare al menu..."
    read 
done
## Il problema: Immagina di scegliere "Info Sistema".
## Lo script stampa le info e il ciclo while ricomincia immediatamente. Il comando clear (dentro mostra_menu) 
## cancellerebbe le info prima che tu riesca a leggerle!

## La soluzione: Questo read finale senza variabili serve solo a mettere in pausa lo script.
## Il computer aspetta che tu prema Invio prima di arrivare alla parola done, ricominciare il ciclo e pulire lo schermo.