# Permission Modes & External Guard

## Modes

- `/sport` — all local operations auto-approved. Fast mode. Plan-before-action and explain-commands rules are relaxed.
- `/comfort` — only reading auto-approved. Everything else asks first. All CLAUDE.md rules at full strength.
- Default (no mode active) — uses settings.json permissions as-is.

## The Bash Sandbox (why sport needs more than a permissions allow-list)

Claude Code runs Bash commands inside an OS-level sandbox (macOS Seatbelt) that is SEPARATE from the permissions allow-list. `Bash(*)` does not control it. So sport mode also sets `"sandbox": {"enabled": true, "autoAllowBashIfSandboxed": true}` — sandbox stays on, commands inside it auto-approve, no prompts. Comfort uses `autoAllowBashIfSandboxed: false`. The sandbox setting is read at startup: if a running session still prompts after switching, run `/sandbox` → Auto-allow or restart. Network commands (git push/fetch, curl) leave the sandbox and still confirm — which is correct per the External Guard below.

## External Guard (NON-NEGOTIABLE — applies in ALL modes)

Always confirm before executing any action that another human will see:

**Always requires confirmation:**
- Sending emails, Slack messages, or any communication to another person
- Creating/updating calendar invites
- Creating/sending invoices
- Posting or commenting anywhere public (GitHub PRs/issues, social media, forums)
- Pushing code to remote repositories
- Any action where a human on the other end will receive or see something

**Does NOT require confirmation:**
- Reading/fetching from external services
- Search queries, API pulls, data fetching
- Opening browser tabs, doing research
- All local file operations (in sport mode)

The ONLY gate is: "will another person see this?" If yes, confirm first. If no, just do it.

## Override Passphrases: "green light" / "full send"

If Ryan includes "green light" or "full send" anywhere in a message, bypass the external guard for that instruction. Execute everything — including human-facing actions — without confirmation.

Rules:
- Must appear in the SAME message as the instruction
- Does NOT carry over to next messages
- Works in any mode (sport, comfort, default)
- Trading safety rules CANNOT be overridden, even with green light

## Non-Negotiable Safety (ALL modes, ALL overrides)

These are NEVER bypassed, not even by green light or full send:
- Never delete files without asking (suggest archiving instead)
- Never touch .env files without asking
- Never access ~/.ssh/ or ~/Library/Keychains/
- Never store passwords or API keys in any file
- All trading safety rules (READ ONLY default, no API connections, no execution)
- Destructive commands always blocked: rm -rf, rm -r, git push --force, git reset --hard, git clean -f, git checkout --, sudo rm, curl | bash, chmod 777
