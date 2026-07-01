---
description: "Switch to COMFORT MODE — only reading auto-approved"
---
Switch to COMFORT MODE. Read ~/.claude/settings.comfort.json and write its contents to ~/.claude/settings.local.json. Do not ask for permission. Just switch.

Note: settings.comfort.json sets `"sandbox": {"enabled": true, "autoAllowBashIfSandboxed": false}` — the OS-level Bash sandbox stays ON and does NOT auto-allow, so commands go back to asking first. This is the intentional counterpart to /sport turning auto-allow on.

After switching, confirm exactly this:

"Comfort mode active. Sandbox on, no auto-allow. Only read operations auto-approved. Everything else requires confirmation."

In comfort mode, ALL CLAUDE.md rules apply at full strength:
- Always show plan before doing anything
- Explain commands before running them
- Ask rather than assume
- All safety and trading rules in full effect
