<div align="center">
  <h1 style="color: #00ffff;">⌨️ Type Newbie Trainer</h1>
  <p><i>"Se non sai digitare veloce, non puoi scappare dai bug."</i></p>
</div>

---

### Cos'è?
**Type Newbie Trainer** Ho creato questo tool per un obiettivo preciso: **allenarmi a scrivere velocemente** in quello che voglio diventi il mio ambiente naturale, ovvero il **terminale**. 

Invece di semplici parole casuali, il trainer utilizza frasi tecniche su LINUX , che spiegano concetti reali di amministrazione di sistema, percorsi di file e flag di comandi.

Invece di usare siti web esterni, ho preferito costruire uno spazio dove la velocità di digitazione si fonde con l'estetica della shell, eliminando ogni distrazione e rendendo familiare un ambiente che spesso spaventa chi è alle prime armi.



###  Funzionalità
* **Feedback Real-time:** I caratteri cambiano colore mentre scrivi (verde se corretti, rosso se errati).
* **Calcolo WPM:** Calcola automaticamente le tue **Parole al Minuto** (Words Per Minute) basandosi sulla velocità di digitazione effettiva.
* **Database Esterno:** Pesca casualmente da un file `frasi.txt` che può contenere frasi lunghe, riflessioni tecniche o comandi terminale complessi.
* **Sessioni Continue:** Alla fine di ogni esercizio, puoi decidere di passare immediatamente alla frase successiva con un semplice tasto.

---

### Come si usa?

1. **Rendi lo script eseguibile:**
   Apri il terminale nella cartella del progetto e digita:
   `chmod +x Type_Newbie_Trainer.sh`

2. **Avvia l'allenamento:**
   `./Type_Newbie_Trainer.sh`

3. **Personalizza le sfide:**
   Aggiungi nuove frasi o comandi complessi nel file `frasi.txt` (una riga per ogni sfida).

---

###  Logica del calcolo WPM
Il calcolo si basa sulla formula standard:
`WPM = (Caratteri digitati / 5) / (Tempo in minuti)`
Nello script viene ottimizzata per Bash per gestire il calcolo in secondi e restituire un valore intero preciso.

---

### Struttura 
* `Type_Newbie_Trainer.sh`: Lo script principale contenente la logica di cattura input e calcolo statistiche.
* `frasi.txt`: Il file di testo contenente il database delle sfide.

---

<div align="center">
  <p>Torna alla <a href="../README.md">Main Lab Area</a></p>
</div>
