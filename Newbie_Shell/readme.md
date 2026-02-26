# 💻 My Perfect Linux Terminal

Ecco come ho configurato il mio terminale Linux per ottenere un setup **perfetto, funzionale e bello da vedere**, usando:

> 🐱 **Kitty** • 🚀 **Starship** • ⚡ **Fastfetch** • 

---

## 🧩 1. Installare Kitty

[Kitty](https://sw.kovidgoyal.net/kitty/) è un terminale moderno, veloce e altamente personalizzabile.

### 🐧 Installazione su Debian/Ubuntu

```bash
sudo apt update
sudo apt install kitty
```

Oppure, per avere **sempre l’ultima versione**:

```bash
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh
```

---

## 🎨 2. Scegliere il Tema Dracula

Ho scelto il tema **Dracula** per avere un terminale coordinato al mio tema di sistema.

Per installare e scegliere i temi di Kitty:

```bash
kitten themes
```

📌 Sfoglia i temi e scegli il tuo preferito — il mio è **Dracula** 🦇

---

## ⚙️ 3. Configurare Kitty

Il file principale di configurazione di Kitty si trova in:

```
~/.config/kitty/kitty.conf
```
Edito il file con 
```
nano ~/.config/kitty/kitty.conf
```

Ecco le mie modifiche principali:

```conf
# Nascondo le decorazioni della finestra
hide_window_decorations yes

# Trasparenza leggera
background_opacity 0.99

# Scorciatoie per le tab
map ctrl+shift+t new_tab
map alt+4 close_tab

# Tema Dracula
# BEGIN_KITTY_THEME
include current-theme.conf
# END_KITTY_THEME
```
Ctrl+o per salvare / Ctrl+x per chiudere nano 

---

## 🧰 4. Impostare Kitty come Terminale di Default

Per aprire Kitty con **Ctrl + Alt + T**:

1. Apri le impostazioni delle scorciatoie da tastiera del tuo DE (GNOME, KDE, XFCE…)
2. Crea una nuova scorciatoia:
   - **Comando:** `kitty`
   - **Scorciatoia:** `Ctrl+Alt+T`

---

## 🚀 5. Installare Starship Prompt

[Starship](https://starship.rs/) è un prompt **moderno, veloce e altamente personalizzabile**.

### Installazione

```bash
curl -sS https://starship.rs/install.sh | sh
```

Poi aggiungi al tuo `.bashrc` o `.zshrc`:

```bash
eval "$(starship init bash)"   # oppure zsh se usi zsh
```

🧠 **Il mio setup:**  
- Preset: **Powerline**
Per applicare il PRESET incolla il comando:

```bash
starship preset pastel-powerline -o ~/.config/starship.toml
```

- Font: **Cascadia Cove Nerd Font** ([Download](https://www.nerdfonts.com/font-downloads))
Scarica e installa un nerd font da questo sito per poter visualizzare correttamente le icone e i simboli
Poi Riavvia il sistema

---

## ⚡ 6. Installare Fastfetch

[Fastfetch](https://github.com/LinusDierheimer/fastfetch) mostra le informazioni di sistema in modo elegante e veloce.

### Installazione su Debian/Ubuntu

```bash
sudo apt install fastfetch
```

### Configurazione
0. In questo repository sono presenti 2 file  `logo.png` e `config.jsonc` : clicca sui file e scaricali usando il pulsante download nella pagina in alto a destra


1. Copia `logo.png` e `config.jsonc`  in:

```
~/.config/fastfetch/
```

2. Esegui Fastfetch con:

```bash
fastfetch --config ~/.config/fastfetch/config.jsonc
```

3. Oppure aggiungi al tuo `.bashrc`:

```bash
fastfetch
```

---

## 💡 Bonus Tips

- 🎛️ Personalizza Starship: colori, simboli, layout e prompt su misura.  https://starship.rs/presets/
- 🧩 Fastfetch può mostrare qualsiasi immagine.png e dato — basta modificare il `.jsonc` e modificare i valori di "logo" :

"logo":  {
    "source": "/home/enthusiast_newbie/.config/fastfetch/logo.png",
    

---

💬 **Autore:** [Enthusiast Newbie](https://github.com/enthusiast-newbie)  
**Seguimi sul mio canale YouTube** per vedere tutti i passaggi in azione e configurazioni extra:  
[https://www.youtube.com/@EnthusiastNewbie](#)
