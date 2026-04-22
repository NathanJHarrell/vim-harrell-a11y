# Fonts

Terminal vim doesn't have its own font setting — it uses whatever font
the terminal emulator is configured for. So accessibility fonts get
installed at the OS level and selected in the terminal config.

## Recommended fonts (in order of "try this first")

### 1. Atkinson Hyperlegible (preferred default)
Designed by the Braille Institute for low-vision readers. Every glyph is
engineered for distinguishability (no `Il1` / `O0` confusion), but it
*reads as a normal font* — code and screenshots don't look "weird."
Best balance of accessibility and aesthetics.

- Download: https://brailleinstitute.org/freefont
- Variants: Regular, Bold, Italic, BoldItalic — all useful.

**Note:** Atkinson Hyperlegible is *proportional*, not monospace, so it
won't work as a terminal font. Use it for documents/notes; pair it with
a monospace below for terminal/code.

### 2. Lexend (proportional, dyslexia-research-backed)
Research from the Lexend project shows measurable reading-speed gains
for some readers (especially those with dyslexia). Comes in several
"deck" widths if you want to experiment with what feels best.

- Download: https://www.lexend.com/

### 3. OpenDyslexic (the famous one)
Weighted bottoms on every glyph to anchor letters and reduce flipping
(b/d/p/q confusion). It looks unmistakably "dyslexia-font" — strong
medicine, but effective for some readers.

- Download: https://opendyslexic.org/

### 4. Monospace pairings (for terminal vim / code)
If you use Atkinson or Lexend for prose, pair with one of these for
the terminal:
- **JetBrains Mono** — Excellent ligatures, very readable.
- **Iosevka** — Narrow but clear; good if you want a lot of columns.
- **Comic Code** (paid) — Comic Sans-style monospace, surprisingly
  legible for dyslexic readers.

## Installation (Linux)

1. Download the `.ttf` or `.otf` files.
2. Drop them into `~/.local/share/fonts/`:
   ```bash
   mkdir -p ~/.local/share/fonts
   cp ~/Downloads/Atkinson*.ttf ~/.local/share/fonts/
   ```
3. Refresh the font cache:
   ```bash
   fc-cache -f
   ```
4. Verify:
   ```bash
   fc-list | grep -i atkinson
   ```

## Selecting in foot (CHArOS terminal)

Edit `~/.config/foot/foot.ini`:

```ini
[main]
font=JetBrainsMono Nerd Font:size=14
# font-bold=Atkinson Hyperlegible:size=14   # if you want a different bold
```

Then reload foot (close + reopen, or send SIGUSR1).

## Selecting in WSL / Windows Terminal (Jarvis)

Windows Terminal: Settings → Profile → Appearance → Font face.
Install fonts via Windows (right-click `.ttf` → Install).

## No-internet fallback

If a fresh machine has no font files and no network, you still get a
reasonable default — the system monospace is usually `DejaVu Sans Mono`
or similar, which is acceptable. Replace it later when you have fonts.
