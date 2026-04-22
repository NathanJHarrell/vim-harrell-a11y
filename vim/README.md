# vim — Accessibility Configuration

## What this is

A vim 8 config tuned for ADHD, Autism, Dyslexia, and vision sensitivity.
It builds on a dyslexia-friendly markdown color foundation and adds
focus-protection, predictability, and visibility wins on top.

Designed to live at `~/.vimrc`. Pure vim — no plugins, no plugin manager,
no external dependencies. If you can boot a machine and run vim, you can
run this config.

## Install

```bash
# Bare-metal install — vim only, no internet required.
cp vim/vimrc ~/.vimrc
mkdir -p ~/.vim/undo
```

That's it. Open vim, you're done.

## Why each section exists

The config has six layers, in order of how they appear in the file.

### 1. Foundation (lines 1–32)
Standard vim hygiene — `nocompatible`, syntax on, sane indenting, mouse
support, system clipboard, status line. Plus the dyslexia-friendly bits:
`linebreak`, `breakindent`, `showbreak=↪` so wrapped lines are
visually anchored to their parent line and don't blur into the next
paragraph.

### 2. Accessibility additions (added 2026-04-22)
The new layer. Every line serves a specific axis:

| Setting | Axis | Why |
|---|---|---|
| `noerrorbells visualbell t_vb=` | ADHD | Bell flashes are focus-killers. Kill them all. |
| `lazyredraw` | ADHD | Smoother scrolling, less visual noise during macros. |
| `undofile` + `undodir` | ADHD | Undo history persists across sessions. "Wait, what did I just do an hour ago?" → still recoverable. |
| `FocusLost autosave` | ADHD | Task-switching is fast and unconscious. You literally cannot lose work to a forgotten `:w`. |
| `<Esc>` clears search | ADHD | No lingering yellow distractions after you've moved on. |
| `splitright splitbelow` | Autism | Splits always go the same direction. No surprise. |
| `confirm` | Autism | Prompts instead of erroring on `:q` with unsaved changes. Predictable. |
| `signcolumn=yes` | Autism | Gutter never shifts when a sign appears. Layout is stable. |
| `nojoinspaces` | Polish | Single space after period when joining lines. Less noise. |

### 3. Tab hotkeys (browser-like)
- `Ctrl+T` → new tab
- `Ctrl+W` then `T` → close tab
- `gt` / `gT` → cycle tabs (vim builtin)

The mental model is the browser, not vim — that's the point. Memorability
beats vim-orthodoxy for an ADHD operator.

### 4. Markdown filetype tweaks
`conceallevel=0` keeps all markdown syntax visible (dyslexia: hidden
characters break reading flow). Spell check on. No automatic line wrap
at any column.

### 5. Markdown color overrides (HarrellMarkdownColors)
The dyslexia-friendly palette:
- **Headings:** purple at six brightness levels (family color).
- **Bold:** warm orange `#FFB86C` — pops without screaming.
- **Italic:** cyan `#8BE9FD`, **no italic styling** — italic letters
  lean and merge for dyslexic readers. Color carries the emphasis.
- **Blockquotes:** soft yellow `#F1FA8C`, also no italic.
- **Code:** green `#50FA7B` (Dracula-style).
- **Links:** pink `#FF79C6` underlined.

If you want to extend, add highlights inside `s:HarrellMarkdownColors()`
so the per-buffer reapplication keeps working.

### 6. Generic UI polish
- `Normal` background `#1F1916` — warm near-black, brown undertone.
  Candlelight feel, easier on eyes than cool gray for long sessions.
- `SpellBad` is a bold high-contrast red bed — visible from across the room.
- Cursor line / status line / search highlighting all tuned for contrast
  without being shrill.

## Per-machine notes

- **tc-nest** (NixOS, foot terminal): renders all 24-bit colors correctly.
- **Jarvis-WSL** (Ubuntu in WSL2, Windows Terminal): also fine for
  truecolor. Mouse support works; clipboard via `unnamedplus` requires
  WSLg or `clip.exe` integration to round-trip with the Windows clipboard.

## Things this config does NOT do

- No LSP (vim 8 alone, no plugins).
- No treesitter (same).
- No per-pane background colors (vim 8 limitation — `Normal` is global).
  See the top-level `README.md` for the neovim future-work note.
- No font configuration (terminal-level — see `../fonts/README.md`).
