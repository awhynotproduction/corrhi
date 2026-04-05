# Architecture

## System Overview

corrhi is three layers:

1. **Knowledge layer** — Obsidian vault with structured folders, templates, and wiki-linked notes
2. **Intelligence layer** — Claude Code with persistent memory, behavioral rules, and skills
3. **Autonomy layer** — Scheduled background execution, remote access, credit pacing

## Memory Hierarchy

Claude's memory has three tiers, in order of reliability:

```
Tier 1: CLAUDE.md (loaded every session, highest compliance)
  Standing behavioral rules, tool routing, autonomy protocol

Tier 2: Memory files (_claude/memory/, searchable)
  feedback_* — behavioral corrections
  user_* — identity, preferences
  project_* — project context
  reference_* — frameworks, tools

Tier 3: approval-diffs.md (raw correction log)
  Input to tune-claude, no direct behavioral effect until synthesized
```

Corrections flow upward: diffs → memory files → CLAUDE.md rules.

## Session Architecture

```
User types "c" (alias for claude "go")
  ↓
SessionStart hook fires
  → Count _review/ items
  → Count unprocessed captures
  → Instruct Claude to load context
  ↓
/open-session skill runs
  → Read goals.md (session handoff)
  → Check _review/ for proposals
  → PM check-in (3-6 lines)
  ↓
Interactive session
  → User works with Claude
  → Corrections logged to approval-diffs.md
  → Auto-commit hook fires on vault writes
  ↓
/close-session skill runs
  → Save summary to goals.md
  → Check for missed corrections
  → Update usage-log.md
  → Git commit + push
```

## Remote Access (Tier 3)

Two launchd agents keep a persistent Claude session accessible from both laptop and phone:

```
com.corrhi.claude-remote (KeepAlive)
  ↓
persistent-remote.sh
  → Wait for WiFi
  → Start tmux session (headless)
  → Run: claude --remote-control
  → If claude exits → tmux exits → launchd restarts in 30s

com.corrhi.dispatch-window (KeepAlive)
  ↓
dispatch-window.sh
  → Wait for tmux session
  → Open Terminal.app window attached via tmux attach
  → If window closed → launchd reopens in 10s
```

**Why two agents:** Terminal.app crashing or closing doesn't kill the claude session. The tmux session (and mobile access via claude.ai/code) survives. The Terminal window is just a viewport.

**Why tmux over screen:** GNU screen doesn't support truecolor (24-bit color). Claude Code's UI renders with degraded colors through screen. tmux supports truecolor natively. Requires `TMUX=` (unset) when launching claude due to a Bun runtime bug where color detection forces 256-color mode inside tmux.

**Prerequisites:** `brew install tmux`

## Autonomous Execution (Tier 3)

```
Every 30 minutes (launchd polls)
  ↓
autonomous-work.sh runs guards:
  1. No concurrent session? (lockfile)
  2. Internet available?
  3. claude CLI exists?
  4. Tasks due in claude-todos.md?
  5. Credit budget available? (5hr window + dynamic weekly threshold)
  ↓
If all pass: burst execution begins
  Phase 1: Recurring tasks (serial, one claude session)
  Phase 2: Active one-time tasks (parallel, up to 3 workers)
  ↓
Between batches: re-check credits, continue if 5hr < 90%
  ↓
Results written to _review/ as project-tasks
  ↓
Credits deplete → polls skip ~5hrs → credits roll off → next burst
  ↓
Next interactive session: open-session surfaces results
```

### Credit Pacing

The 5-hour rolling window is the primary governor. Polls are cheap (just a curl + credit check, zero tokens). When credits are available, burst. When depleted, skip instantly.

**Thresholds:**
- **5hr window:** Start burst if < 70%. Between batches, continue up to 90%.
- **Weekly (dynamic):** Scales with time remaining: `60 + 39 * (1 - hours_left / 168)`. Fresh week = 60%. Last day = ~94%. Last 4 hours = ~99%.
- **Sonnet:** Block if > 85%.

**Modes** (set in claude-todos.md frontmatter `mode:`):
- `normal` — 5hr + dynamic weekly governor
- `vacation` — use up to 95%
- `light` — minimal autonomous work

## File Ownership

| Location | Owner | Purpose |
|----------|-------|---------|
| `~/CLAUDE.md` | System | Standing behavioral rules |
| `~/.claude/hooks/` | System | Event-driven integrity checks |
| `~/.claude/skills/` | System | Workflow playbooks |
| `~/.claude/MEMORY.md` | System | Bootstrap identity (auto-loaded) |
| `vault/` (except _claude/) | User | User's knowledge graph |
| `vault/_claude/` | Claude | Claude's brain (goals, lens, memory, research) |
| `vault/_review/` | Shared | Proposal bridge between brains |

## Weekly Calendar Ritual

Every Monday at 9:30am, a recurring calendar event triggers a review session:

1. **Retrospective** — Compare previous week's scheduled work blocks against what actually happened. Log in `_claude/calendar-log.md`.
2. **Planning** — Read goals.md, project deadlines, existing calendar. Propose work blocks for the week ahead.
3. **Pattern recognition** — Over time, the log reveals which block types have the best follow-through, what time slots get protected, and how to schedule smarter.

Claude manages the calendar directly (Google Calendar MCP), adding studio blocks, Claude work sessions, wedding planning, and project-specific time. The calendar becomes a reflection of active project priorities, not just appointments.

## Hook Architecture

| Hook | Trigger | Purpose |
|------|---------|---------|
| trust-the-file | UserPromptSubmit | Verify against disk before responding |
| session-start | SessionStart | Vault status, load instructions |
| session-stop | Stop | Warn uncommitted changes |
| validate-yaml | PostToolUse(Write) | Check frontmatter on vault writes |
| auto-commit | PostToolUse(Write/Edit) | Git commit vault changes |
| resize-images | PreToolUse(Read) | Shrink large images before reading |

## Skill Architecture

Skills are markdown playbooks in `~/.claude/skills/[name]/SKILL.md`. They tell Claude HOW to do something, loaded on demand (not every session).

| Skill | User-invocable | Purpose |
|-------|---------------|---------|
| /onboard | Yes | First-run calibration |
| /open-session | Yes | Session start check-in |
| /close-session | Yes | Session end protocol |
| /review | Yes | Proposal review workflow |
| process-inbox | No | DRC pipeline on captures |
| reweave | No | Backward pass — connections, staleness |
| tune-claude | No | Synthesize corrections into lens |
| vault-health | No | System health dashboard |
