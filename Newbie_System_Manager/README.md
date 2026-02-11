# Newbie System Manager

Un **System Manager** interattivo basato su Bash.
Nato come esercizio pratico durante il mio studio per la certificazione **LPIC-1**, questo tool automatizza le operazioni quotidiane su Linux (Debian/Ubuntu based).
Semplice script che unisce la teoria (comandi `find`, `grep`, `awk`) alla pratica reale.
Il mio obiettivo è condividere il percorso di chi impara sbattendo la testa sui problemi.

![Bash](https://img.shields.io/badge/Language-Bash-4EAA25?style=flat&logo=gnu-bash)
![Linux](https://img.shields.io/badge/OS-Linux-FCC624?style=flat&logo=linux)
![Status](https://img.shields.io/badge/Status-v1.0_Stable-blue)


##  Le 7 Funzioni
Il programma offre un menu TUI (Text User Interface) con queste capacità:

1.  **Info Sistema:** Dashboard con Kernel, OS, CPU, Spazio Disco e RAM (filtrati con `awk`).
2.  **Aggiornamento:** Esegue `apt update` e `upgrade` .
3.  **Gestione Utenti:**
    * Visualizza gli utenti umani già esistenti.
    * usa `adduser` per creare nuovi utenti .
4.  **Pulizia:** Rimuove pacchetti orfani e cache apt.
5.  **Network:**
    * Mostra IP locale e interfaccia attiva.
    * **Ping Test:** Verifica la connessione internet.
6.  **Caccia allo Spazio Occupato:**
    * Trova le directory più pesanti.
    * Ricerca sia nella Home (veloce) che nella Root (lenta).
7.  **File Seeker (Matrix Mode):**
    * Cerca file in tutto il sistema usando pattern case-insensitive.


##  Cosa ho imparato costruendolo
Questo progetto è stato una palestra per capire le sfumature di Bash:

* **La trappola dell'IF:** Ho scoperto che `if [ condizione ]` serve per testare valori, ma se voglio verificare se un comando funziona (come `ping`), devo togliere le parentesi quadre: `if ping ...`.
* **Standard Error:** Ho imparato a gestire i permessi negati usando `2>/dev/null` per nascondere gli errori e pulire l'output visivo.
* **Case Annidati:** La funzione n.6 usa un `case` dentro un altro `case` per gestire i sottomenu.
* **Awk Power:** Invece di usare cat+grep+cut, ho imparato che `awk 'NR==2 {print $4}'` è il modo più chirurgico per estrarre dati da comandi come `df` o `free`.

*Creato con passione da [Enthusiast Newbie](https://enthusiastnewbie.com)*
*Seguimi su YouTube: [@enthusiastnewbie](https://youtube.com/@enthusiastnewbie)*
