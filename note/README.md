# note — Quick Capture Drawer

## What this is

A bash script that opens a vim window seeded with the Evergreen
quick-capture template, in a left-anchored floating drawer (when run
under sway with the right window rule).

Wired to `Cmd+N` (Super+N) on tc-nest. No hotkey on Jarvis yet — see
"Per-machine notes" below.

## Files

- `note` — the script. Goes at `~/.local/bin/note` (or anywhere on PATH).
- `templates/evergreen.md` — the template, by itself, for reference or
  reuse with other tools.

## Install

```bash
cp note/note ~/.local/bin/note
chmod +x ~/.local/bin/note
mkdir -p ~/Manor/Nathan/inbox
```

Test:
```bash
note test-from-readme
# vim opens with the template seeded, cursor in "## The Idea"
```

## Usage

```bash
note                    # new file: ~/Manor/Nathan/inbox/<timestamp>.md
note <slug>             # new file: ~/Manor/Nathan/inbox/<slug>.md
note path/to/file.md    # open that exact file (existing or new)
```

When the file is new, it's seeded with the Evergreen template and the
cursor lands on the blank line under `## The Idea`. Type immediately.

When the file already exists, it just opens — no template seeding.

## Sway integration (tc-nest only)

See `../sway/note-binding.conf` for the snippet. Two lines:

1. `for_window [app_id="note"]` — pin note windows as a 384×640 drawer
   at `(0, 80)`. This is what makes it a *drawer* rather than a window.
2. `bindsym $mod+n exec ~/.local/bin/note` — Super+N hotkey.

The script invokes `foot --app-id=note ...` so the window-rule matches.

## The Evergreen template — design rationale

The template has five sections, in this order:

1. **The Idea** — one concept, one paragraph. If it needs two
   paragraphs, it's two notes. Forces the brain to commit.
2. **Why This Matters Right Now** — the ADHD context-anchor. What made
   you reach for this note this minute? Future-you needs the trigger,
   not just the thought. Without this, half of quick-captures lose
   their meaning within 24 hours.
3. **Connections** — bare wiki-links to other notes/projects/people.
   Maps directly onto Obsidian-style backlinking if you ever migrate
   the inbox into a vault.
4. **Open Questions** — half-formed sparks. Don't resolve them, just
   catch them. The "I'll figure that out later" parking lot.
5. **Sources** — optional. Link, screenshot path, conversation
   timestamp, or just a vibe.

The HTML comments under each heading explain themselves to future-you.
They don't render in the markdown preview, but they're right there in
vim while you're writing — a built-in coach.

## Per-machine notes

- **tc-nest:** Cmd+N hotkey works via sway. Opens as a drawer.
- **Jarvis-WSL:** No sway, no hotkey yet. The script still works as
  `note <slug>` from a shell, just without the drawer behavior. A
  Windows Terminal keybinding could invoke `wsl note <slug>` — but
  that's a future enhancement.

## Customization

If you want a different template:
1. Edit the `cat > "$filepath" <<EOF` block in `note`.
2. Update `cursor_line=7` to wherever the new template wants the cursor.

The cursor line is counted from 1, top of file. Vim's `+N` argument
opens at line N.
