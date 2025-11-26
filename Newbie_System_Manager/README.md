# Enthusiast Newbie System Manager

Un semplice **System Manager** basato su Bash, creato per automatizzare le operazioni quotidiane su Linux (Debian/Ubuntu based).

## 🚀 Funzionalità
Il programma offre un menu interattivo per:

1.  **📊 Info Sistema:** Mostra Kernel, OS, CPU, Spazio Disco e RAM libera.
2.  **🔄 Aggiornamento:** Esegue `apt update` e `upgrade` in sequenza.
3.  **👤 Gestione Utenti:** * Mostra la lista degli utenti reali (con shell Bash) già presenti.
    * Guida la creazione di un nuovo utente usando `adduser`.
4.  **🧹 Pulizia:** Rimuove pacchetti orfani e pulisce la cache di apt.

## 🧠 Cosa ho imparato costruendolo
Questo progetto mi ha aiutato a consolidare diversi concetti LPIC:
* **Awk vs Grep:** All'inizio usavo cat e grep ovunque. Poi ho scoperto che `awk 'NR==2 {print $4}'` è molto più potente per estrarre dati specifici (come la RAM usata) senza sporcare il codice.
* **Automazione Utenti:** Ho imparato la differenza tra `useradd` (basso livello, non crea la home di default) e `adduser` (script interattivo amichevole). Ho scelto il secondo per rendere lo script più sicuro.
* **Exit Codes:** L'importanza di usare `&&` per assicurarsi che l'aggiornamento parta solo se il controllo pacchetti va a buon fine.



## ⚠️ Disclaimer
Questo è un progetto didattico creato da un appassionato che sta imparando. **Leggete sempre il codice prima di eseguire script con permessi di root!**

---
*Creato con ❤️ da [Enthusiast Newbie](https://enthusiastnewbie.com)*
*Seguimi su YouTube: [@enthusiastnewbie](https://youtube.com/@enthusiastnewbie)*
