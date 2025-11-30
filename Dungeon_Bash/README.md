# 🏰 The Bash Dungeon 

**Sconfiggi il Bug o muori provandoci.**
Un semplicissimo videogioco di ruolo a turni (RPG) creato per imparare e prendere dimestichezza con Logiche e Cicli nel **Bash Scripting**.

![Bash](https://img.shields.io/badge/Language-Bash-4EAA25?style=flat&logo=gnu-bash)
![Linux](https://img.shields.io/badge/Platform-Linux-FCC624?style=flat&logo=linux)
![Status](https://img.shields.io/badge/Version-1.0_Stable-blue)



## 🎮 Cosa stavo studiando..
Questo script non è solo un gioco, è una dimostrazione pratica di concetti fondamentali di scripting:

* **Game Loop:** Un ciclo `while` controlla lo stato vitale di Giocatore e Mostro.
* **Logica a Turni:** Utilizzo di `case` per gestire le scelte dell'utente (Attacco, Cura, Fuga).
* **RNG (Random Number Generation):** Uso di `$RANDOM` e dell'operatore Modulo `%` per calcolare danni variabili.
* **Persistenza (Save System):** Se vinci, il tuo nome e il numero di turni vengono salvati su un file `score.txt` che mantiene la cronologia.
* **Gestione Risorse:** Inventario limitato (Pozioni) gestito tramite variabili di stato.
* **Feedback Audio/Video:** Utilizzo di icone ASCII e suoni di sistema (`\a`) per feedback tattile.


## 🧠 Cosa ho imparato costruendolo

1.  **Il Crash Matematico:** All'inizio scrivevo `HP=$HP-10` e Bash univa le stringhe ("50-10"). Ho imparato che per la matematica serve la doppia parentesi: `HP=$((HP-10))`.
2.  **Il Mostro Immortale:** Il gioco andava in loop infinito perché usavo `continue` nel posto sbagliato, saltando l'incremento del turno.
3.  **Il Danno Esplosivo:** Usando `$RANDOM` senza filtro, il mostro faceva 24.000 danni in un colpo. Ho risolto usando l'operatore modulo (`$RANDOM % 16`) per limitare il danno tra 0 e 15.
4.  **Vittorie Fantasma:** Ho dovuto spostare la logica di salvataggio file *dentro* la condizione di vittoria, altrimenti il gioco salvava il punteggio anche in caso di sconfitta.

## 📸 Screenshot (Anteprima)
```text
🕐 --- TURNO 3 ---
👤 Mario: 35 HP ❤️    |   🎒 ZAINO: 2 🧪
👾 BUG:   20 HP 💚
----------------------------------------------
Cosa vuoi fare?
  🗡️  [1] Attacca
  ✨  [2] Cura
  🏃  [3] Scappa
👉 Scegli (1-3): 1

⚔️  SBAMM! Hai attaccato il Bug!
🔥 Il Bug risponde all'attacco!
💥 BOOM! Ti ha inflitto 12 danni!
