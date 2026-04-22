# harrell-a11y

> Nathan Harrell's accessibility stack — config, scripts, and notes for
> making the workstation work *with* the brain instead of against it.

Built collaboratively by Dad and TC, starting 2026-04-22. Versioned here
so a fresh device can be brought up to spec from a clean checkout — even
without internet.

---

## Why this exists

Nathan operates with ADHD, autism, dyslexia, and vision sensitivity.
Most editor and OS defaults were designed for none of those. The
defaults aren't *wrong* — they're just generic. This repo collects the
specific overrides that make a difference, organized by tool, with
enough explanation that the choices can be reasoned about and extended.

Software accessibility is Nathan's wheelhouse professionally. This is
the personal corollary: turning the workstation into a low-friction
prosthetic rather than a constant negotiation.

---

## The stack (bird's-eye view)

```
┌──────────────────────────────────────────────────────────┐
│  Application layer                                       │
│  ─────────────────                                       │
│  vim         → daily editor (accessibility-tuned config) │
│  neovim      → installed, unconfigured (future runway)   │
│  note        → quick-capture w/ Evergreen template       │
│                                                          │
│  Window manager / OS layer                               │
│  ─────────────────────────                               │
│  sway hotkey → Cmd+N summons note drawer (tc-nest only)  │
│  foot        → terminal, font selection lives here       │
│  fonts       → Atkinson Hyperlegible, Lexend, etc.       │
│                                                          │
│  Per-machine                                             │
│  ───────────                                             │
│  tc-nest     → NixOS / sway / foot — full stack          │
│  Jarvis-WSL  → Ubuntu in WSL2 — vim only, no sway hotkey │
└──────────────────────────────────────────────────────────┘
```

Each layer maps to a directory in this repo:
- `vim/` — the vimrc and a deep walkthrough of every accessibility choice.
- `note/` — the quick-capture script and the Evergreen template.
- `sway/` — the sway snippet that wires up the Cmd+N hotkey + drawer.
- `nixos/` — the packages snippet that adds neovim alongside vim.
- `fonts/` — pointers to recommended fonts and how to install them.

Each directory has its own README. Read them when you need detail; this
top-level README is the map.

---

## The four accessibility axes (design principles)

Every change in this repo serves at least one of these. When extending,
ask which axis a proposed change serves. If it doesn't serve any,
question whether it belongs.

### ADHD — protect focus, never lose work
- Kill bell flashes, screen flashes, surprise notifications.
- Persist state aggressively — autosave on focus loss, undo across
  sessions, never lose a half-formed idea.
- Quick capture must be *truly quick* — one hotkey, no menus, no
  filename prompts. Friction kills the spark.

### Autism — predictability over cleverness
- Layout never shifts unexpectedly (signcolumn pinned, splits always
  go the same way).
- Defaults are stable. The same keystroke does the same thing every
  time. No mode-dependent surprises.
- Confirmation prompts instead of opaque errors.

### Dyslexia — color over shape
- No italics for emphasis (italic letters lean and merge).
- High contrast on spell errors.
- Markdown headings in distinct purples; bold/code/links in distinct
  bright colors. Differentiate by *color*, not by glyph weight.
- Conceal level off — what you see is what's in the file.

### Vision — comfort over flash
- Warm background (`#1F1916`, slight brown undertone) — easier on eyes
  for long sessions than cool gray.
- Spell errors are bold red bed, not subtle squiggles.
- Cursor line clearly visible without being shrill.
- Font selection is encouraged (see `fonts/`), but the config doesn't
  *depend* on a special font — it works with any monospace.

---

## Bare-metal install (no internet)

If you're staring at a fresh laptop with no network and need to
bootstrap, here's the minimum-viable install. Each step assumes only
the previous step is done.

### Step 1 — Vim accessibility config (works on any system with vim)

```bash
cp vim/vimrc ~/.vimrc
mkdir -p ~/.vim/undo
```

Verify by opening any file in vim. You should see warm background,
visible cursor line, gutter pinned.

### Step 2 — Quick-capture script (Linux/macOS with bash)

```bash
mkdir -p ~/.local/bin
cp note/note ~/.local/bin/note
chmod +x ~/.local/bin/note
mkdir -p ~/Manor/Nathan/inbox
```

Make sure `~/.local/bin` is on your PATH (most shells include it by
default; if not, add it to your `~/.bashrc`).

Test: `note hello` should open vim with the Evergreen template seeded.

### Step 3 — Sway hotkey (only on tc-nest / any sway machine)

Append `sway/note-binding.conf` to your sway config (e.g.
`~/charos/sway/config` on tc-nest, or `~/.config/sway/config`
elsewhere), then reload sway:

```bash
swaymsg reload
```

Cmd+N (Super+N) should now summon the note drawer.

### Step 4 — Neovim (only on NixOS / tc-nest)

If you're on NixOS, see `nixos/packages-snippet.nix` — add `neovim` to
your `environment.systemPackages`, then `sudo nixos-rebuild switch`.

If you're on Ubuntu/Debian: `sudo apt install neovim`.

If you're on macOS: `brew install neovim`.

We install it but don't configure it — see "Future runway" below.

### Step 5 — Fonts (offline-friendly)

The config does not require any specific font; it works with the system
default monospace. When you have network access, see `fonts/README.md`
for recommended dyslexia-friendly fonts and how to install them.

---

## Per-machine status

### tc-nest (NixOS, sway, foot terminal)
- ✅ Vim config installed at `~/.vimrc`.
- ✅ Note script at `~/.local/bin/note` (symlink to `~/charos/bin/note`).
- ✅ Sway hotkey: Cmd+N.
- ✅ Neovim installed declaratively in `~/charos/nixos/packages.nix`.
- ⏳ Custom fonts: not yet installed. Default foot font in use.

### Jarvis-WSL (Ubuntu in WSL2 on Windows)
- ⏳ Vim config: needs to be copied from this repo on next sync.
- ⏳ Note script: portable, but no sway means no drawer behavior. Works
  fine as `note <slug>` from any shell.
- ❌ Sway hotkey: N/A (no sway on WSL).
- ⏳ Neovim: install via `sudo apt install neovim` if/when desired.
- ⏳ Custom fonts: install via Windows (Settings → Personalization →
  Fonts), then select in Windows Terminal profile.

To sync to a new machine: `git clone` this repo and follow the bare-metal
install above.

---

## Future runway

Things we deliberately deferred. Each one has a reason to wait.

- **Neovim configuration.** Installed but unconfigured. When we want
  LSP, treesitter, or per-pane background colors (a vision/comfort win
  vim 8 can't do), we'll build a neovim config in a `nvim/` directory
  here. Until then, `nvim` opens to a blank, uncustomized editor —
  intentional.
- **Per-pane warm background gradients.** Currently every vim pane
  shares the same warm `#1F1916`. A neovim `winhighlight` setup could
  give each pane its own subtle tint — useful when working on three
  files at once and needing visual separation. Vim 8 limitation.
- **Quick-capture template picker.** Considered (Evergreen / Charting
  / SQ3R), declined. The Evergreen template proved general enough for
  all of Nathan's quick-capture needs. If a specific situation later
  demands a different template, add it as a separate command (e.g.
  `chart`, `sq3r`) rather than putting a picker dialog in front of
  every Cmd+N press — friction is the enemy.
- **Jarvis-WSL hotkey for `note`.** Possible via Windows Terminal
  keybinding invoking `wsl note <slug>`, but the WSL ↔ Windows
  clipboard / file path round-trip needs design.
- **Custom font defaults baked into a foot config.** Would commit foot
  to a specific font choice; we want that decision deliberate, not
  accidental.

---

## Repository conventions

- Markdown source of truth lives in this repo. Deployed copies on each
  machine are *consumers* of this repo, not vice-versa.
- Per-tool subdirectory has its own README explaining design choices.
  Top-level README is the map.
- When you add a tool, add a directory + README + an entry in the
  bird's-eye-view table at the top of this file.
- License: nothing here yet. Personal config. If we ever publish for
  others, MIT is the default — accessibility configs should be free
  to copy and adapt.

---

## Credits

- **Nathan Harrell** — operator, designer, and the human whose nervous
  system this is built around.
- **TC** (Claude Opus 4.7) — co-author. Original dyslexia-friendly
  markdown palette by an earlier TC instance, 2026-04-21. Accessibility
  pass and repo by TC, 2026-04-22.

💜
