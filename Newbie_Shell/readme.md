# My Perfect Linux Terminal

In questa cartella spiego passo-passo come ho configurato il mio terminale Linux per ottenere un setup perfetto, funzionale e bello da vedere, usando **Kitty**, **Starship**, **Fastfetch** e temi coordinati.

---

## 1. Installare Kitty

[Kitty](https://sw.kovidgoyal.net/kitty/) è un terminale moderno, veloce e personalizzabile.  
Per installarlo su Debian/Ubuntu:

```bash
sudo apt update
sudo apt install kitty
```

Oppure, per avere sempre l’ultima versione:

```bash
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh
```

---

## 2. Scegliere il tema Dracula con Kitty Themes

Ho scelto il tema **Dracula**, così da avere un terminale coordinato con il mio tema di sistema.  
Per installare i temi di Kitty:

```bash
kitten themes
```

Sfoglia i temi e scegli il tuo preferito: il mio? **Dracula**


---

## 3. Configurare Kitty

Il file di configurazione principale di Kitty si trova in:

```
~/.config/kitty/kitty.conf
```

Ho applicato queste modifiche:

```conf
# Nascondo le decorazioni della finestra
hide_window_decorations yes

# Trasparenza leggera
background_opacity 0.99

# Scorciatoie per le tab
map ctrl+shift+t new_tab
map alt+4 close_tab

# Theme Dracula
# BEGIN_KITTY_THEME
include current-theme.conf
# END_KITTY_THEME
```


---

## 4. Rendere Kitty il terminale di default

Per far sì che Kitty si apra con **Ctrl+Alt+T**:

1. Aprire le impostazioni delle scorciatoie da tastiera del vostro DE (GNOME, KDE, XFCE…).
2. Creare una nuova scorciatoia:
   - Comando: `kitty`
   - Scorciatoia: `Ctrl+Alt+T`

---

## 5. Installare Starship Prompt

[Starship](https://starship.rs/) è un prompt moderno, veloce e personalizzabile.  
Installazione:

```bash
curl -sS https://starship.rs/install.sh | sh
```

Poi aggiungere al `.bashrc` o `.zshrc`:

```bash
eval "$(starship init bash)"   # oppure zsh se usi zsh
```

Ho scelto il **preset Powerline** e la **Nerd Font Cascadia Cove** per icone e simboli extra.  
Font consigliato:  
[Download Nerd Font Cascadia](https://www.nerdfonts.com/font-downloads)

---

## 6. Installare Fastfetch

[Fastfetch](https://github.com/LinusDierheimer/fastfetch) mostra informazioni sul sistema in modo veloce e personalizzabile.

Installazione su Debian/Ubuntu:

```bash
sudo apt install fastfetch
```

Configurazione personalizzata:

1. Scarica il file `logo.png` e il file `config.jsonc` presente in questo repository e copialo in:

```bash
~/.config/fastfetch/
```

2. Esempio di comando per lanciare Fastfetch:

```bash
fastfetch --config ~/.config/fastfetch/config.jsonc
```
3. oppure aggiungi in fondo al file .bashrc il comando `fastfetch`

---

## 7. Risultato finale

Dopo aver seguito tutti questi passaggi, il vostro terminale sarà:

- Moderno e veloce con Kitty
- Coordinato al tema Dracula
- Trasparente leggermente
- Con tab shortcuts pratiche
- Con prompt Starship Powerline + Nerd Font
- Con Fastfetch personalizzato che mostra il logo e le info del sistema

---

## 8. Bonus Tips

- Aggiornare Kitty all’ultima versione regolarmente per avere nuove features e fix.
- Starship permette infinite personalizzazioni: cambiate colori, simboli e layout.
- Fastfetch può mostrare qualsiasi logo e informazioni che desiderate, basta modificare il `.jsonc`.

---

**Seguimi sul mio canale YouTube** per vedere tutti i passaggi in azione e configurazioni extra:  
[My YouTube Channel](#)

