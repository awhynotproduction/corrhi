# Adoption Tiers

## Tier 1: Knowledge System

**Setup time:** 10 minutes
**What you get:** A structured Obsidian vault with templates, CLAUDE.md instructions, and the DRC methodology.

**Includes:**
- 13 organized folders (notes, projects, sources, people, self, maps, lists, writing, capture, templates, _review, _claude)
- Note templates (atomic note, project, source, person, self, capture)
- Vault CLAUDE.md (tells Claude how to work with your vault)
- DRC methodology (the processing framework)
- Starter maps (projects, dashboard, sources)

**What it doesn't include:** Hooks, skills, learning loop, autonomous execution.

**Good for:** Getting started, testing if the vault structure works for you.

## Tier 2: Memory + Learning

**Setup time:** 20 minutes
**What you get:** Everything in Tier 1, plus Claude's brain infrastructure and the learning loop.

**Adds:**
- Home `~/CLAUDE.md` with behavioral rules
- `MEMORY.md` bootstrap (Claude knows who you are every session)
- `[you]-lens.md` (Claude's model of how you think — evolves through corrections)
- `approval-diffs.md` (correction log)
- 7 hooks (trust-the-file, session start/stop, YAML validation, auto-commit, image resize)
- 8 skills (/onboard, /open-session, /close-session, /review, /process-inbox, /reweave, /tune-claude, /vault-health)
- Shell alias `c` for quick session start
- `CORRHI_VAULT` environment variable

**Good for:** Daily use. This is where the system starts feeling like a coworker.

## Tier 3: Full Autonomy

**Setup time:** 30 minutes
**Requires:** Claude Max plan ($100/mo) for sufficient autonomous credits
**What you get:** Everything in Tier 2, plus scheduled background work and remote access.

**Adds:**
- Autonomous execution engine (polls every 30 minutes, credit-window-aligned bursts)
- Scheduled tasks: reweave (weekly), vault-health (weekly), tune-claude (on condition), process-inbox (daily)
- Credit pacing (5hr window governor + dynamic weekly threshold that scales with time remaining)
- Persistent remote-control session (access from phone via claude.ai/code)
- Power management (prevents Mac from sleeping on AC power)
- launchd agents for autonomous + remote sessions

**Good for:** Power users who want Claude working between sessions.

## Upgrading Tiers

Already on Tier 1 and want Tier 2? Run setup.sh again — it's idempotent. It won't overwrite your vault content, just add the missing infrastructure.

```bash
cd corrhi
./setup.sh
# Pick the same vault path, choose tier 2 or 3
```
