---
description: "Switch to SPORT MODE — auto-approve all local operations"
---
Switch to SPORT MODE. Read ~/.claude/settings.sport.json and write its contents to ~/.claude/settings.local.json. Do not ask for permission. Just switch.

Note: settings.sport.json sets `"sandbox": {"enabled": true, "autoAllowBashIfSandboxed": true}`. This is the key that actually stops approval prompts on Bash commands that use shell variables, `[ -f ]` tests, tilde-in-assignment, or command substitution — those prompts come from the OS-level Bash sandbox (macOS Seatbelt), which the permissions allow-list CANNOT override (they are separate layers). `autoAllowBashIfSandboxed: true` keeps the OS sandbox protection ON but auto-approves commands that run inside it — safer than fully disabling the sandbox, and exactly what the built-in `/sandbox` → Auto-allow chooses. The `deny` list still hard-blocks destructive commands regardless.

Two things worth knowing:
- The sandbox setting is read once at Claude Code startup, so writing settings.local.json does NOT change a session that already booted. If a command still prompts right after switching in an already-running session, run `/sandbox` → Auto-allow (applies live immediately) or restart Claude Code. From the next session on it is automatic.
- Commands that need the network or resources outside the sandbox (e.g. `git push`, `git fetch`, `curl`) step OUTSIDE the sandbox and therefore still go through the normal approval flow — this is expected, and aligns with the External Guard (anything reaching a remote should confirm).

After switching, confirm exactly this:

"Sport mode active. Sandbox auto-allow on — all local operations auto-approved, no more permission prompts on scripts or shell commands. Destructive commands still blocked. Human-facing actions still require confirmation. Say 'green light' or 'full send' to bypass that too."

In sport mode, these CLAUDE.md rules are relaxed:
- "Always show me your plan BEFORE doing anything" — just do it
- "Never run commands I haven't seen before without explaining" — just run them

These rules are NEVER relaxed, even in sport mode:
- Never delete anything without explicit approval
- Never touch .env files
- Never access ~/.ssh/ or ~/Library/Keychains/
- Never send data to external services without telling me first
- All trading safety rules remain in full effect
- External Guard: always confirm before any action another human will see
