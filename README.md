# Claude Permission Modes — Sport & Comfort

Two permission modes for Claude Code that switch between fast (auto-approve everything) and safe (approve reads only).

## What This Does

- **`/sport`** — All local operations auto-approved. No permission prompts. Destructive commands still blocked. Human-facing actions still require confirmation.
- **`/comfort`** — Only read operations auto-approved. Everything else asks first.
- **External Guard** — In both modes, any action another human will see (push, email, message, PR) requires confirmation.
- **Green light / full send** — Override passphrases to bypass the external guard for a single message.

## Install

```bash
git clone https://github.com/rcspence1/claude-permission-modes.git ~/Projects/claude-permission-modes
cd ~/Projects/claude-permission-modes
bash install.sh
```

That's it. Open Claude Code and type `/sport` or `/comfort` to switch modes.

## Files Installed

| File | Location | Purpose |
|------|----------|---------|
| `sport.md` | `~/.claude/commands/sport.md` | `/sport` slash command |
| `comfort.md` | `~/.claude/commands/comfort.md` | `/comfort` slash command |
| `settings.sport.json` | `~/.claude/settings.sport.json` | Permissive permissions config |
| `settings.comfort.json` | `~/.claude/settings.comfort.json` | Restrictive permissions config |
| `permissions.md` | `~/.claude/rules/permissions.md` | Mode definitions + External Guard rules |

## How It Works

When you type `/sport`, Claude reads `settings.sport.json` and writes it to `settings.local.json` — which is what Claude Code actually reads for permissions. `/comfort` does the same with the restrictive config.

The `permissions.md` rule file teaches Claude the behavioral differences between modes (what to confirm, what to skip, what's never allowed).

## The Sandbox (important)

Claude Code has an **OS-level Bash sandbox** (macOS Seatbelt) that is a *separate layer* from the permissions allow-list. Even with `Bash` / `Bash(*)` allowed, the sandbox will still prompt for approval on commands that use shell variables, `[ -f ]` tests, tilde-in-assignment, or command substitution. `Bash(*)` **cannot** override it — they control different things.

Sport mode fixes this by setting, in `settings.sport.json`:

```json
"sandbox": { "enabled": true, "autoAllowBashIfSandboxed": true }
```

This keeps the sandbox protection **on** but auto-approves commands that run inside it — no prompts. Comfort mode sets `autoAllowBashIfSandboxed: false` to restore prompting.

Two gotchas:
- **The sandbox setting is read at Claude Code startup.** Switching modes in an already-running session won't change it live. Run `/sandbox` → **Auto-allow**, or restart Claude Code. It's automatic from the next session on.
- **Network commands step outside the sandbox** (e.g. `git push`, `git fetch`, `curl`), so they still go through the normal approval flow. This is expected and matches the External Guard.

## Safety

Even in sport mode, these are always blocked:
- `rm -rf`, `rm -r`, `sudo rm`
- `git push --force`, `git reset --hard`, `git clean -f`
- `curl | bash`, `chmod 777`
- Deleting files without asking
- Touching `.env` files
- Accessing `~/.ssh/` or `~/Library/Keychains/`
