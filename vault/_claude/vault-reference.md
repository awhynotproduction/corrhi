---
type: claude-brain
---

# Vault Reference

## Approval Workflow
1. Claude creates proposal in `_review/`
2. User reviews in Obsidian (or via `/review` skill)
3. Approved: Claude creates note at destination, deletes proposal
4. Rejected: Claude deletes proposal
5. Revised: Claude applies feedback, user re-reviews

## Claude's Brain Directory (`_claude/`)
| File | Purpose |
|------|---------|
| goals.md | Session handoff — last session summary, what's next |
| user-lens.md | Claude's model of user's decision patterns |
| approval-diffs.md | Raw correction log (input to tune-claude) |
| methodology.md | DRC processing methodology (stable reference) |
| claude-todos.md | Task orchestration for autonomous sessions |
| usage-log.md | Session timestamps for pattern learning |
| memory/ | Wiki-linked memory files by type prefix |
| research/ | Autonomous research output |
| archive/ | Completed tasks, session logs |

## Memory File Types
- `feedback_*` — Behavioral corrections with why + how to apply
- `user_*` — User identity, preferences, context
- `project_*` — Project-specific context beyond project files
- `reference_*` — Frameworks, patterns, tools
