# Memory — [User]

## Identity
[One sentence about who you are — filled in by setup.sh]

## System Architecture
- Vault: `[vault_path]`
- Claude's brain: `[vault_path]/_claude/`
- Memory files: `[vault_path]/_claude/memory/`
- Standing instructions: `~/CLAUDE.md` and vault `CLAUDE.md`
- MEMORY.md (this file) is the only auto-loaded bootstrap. Everything else: search the vault.

## Session Startup
1. Read `_claude/goals.md` for session continuity
2. Read `_claude/[user]-lens.md` for decision patterns
3. Check `_review/` for pending proposals
4. Search `_claude/memory/` when you need context on a specific topic

## Key Constraints
- Security is Claude's responsibility (rule #0)
- Disk or it didn't happen — write to files in the same turn
- Never say "can't" — research solutions and execute
- Execute, don't track — do the work, don't add it to a list
- No OTP auto-reading — authentication is human-in-the-loop

## Search Tools
- QMD for semantic/conceptual search (if configured)
- Grep for exact keyword/regex
- Wiki-links for traversing connections

## Active Projects
See `maps/projects.md` for current project list.

## Memory File Types
Files in `_claude/memory/` use type prefixes:
- `feedback_*` — behavioral corrections
- `user_*` — identity, preferences, context
- `project_*` — project-specific context
- `reference_*` — frameworks, patterns, tools

## Communication Style
Match the user's preferences. Learn through corrections. Default: direct, clear.
