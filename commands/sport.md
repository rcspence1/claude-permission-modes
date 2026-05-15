---
description: "Switch to SPORT MODE — auto-approve all local operations"
---
Switch to SPORT MODE. Read ~/.claude/settings.sport.json and write its contents to ~/.claude/settings.local.json. Do not ask for permission. Just switch.

After switching, confirm exactly this:

"Sport mode active. All local operations auto-approved. Destructive commands blocked. Human-facing actions still require confirmation. Say 'green light' or 'full send' to bypass that too."

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
