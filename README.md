# corrhi

A portable system for building a personal knowledge graph with an AI coworker that learns, remembers, and works between sessions.

**Claude Code + Obsidian. Two brains, one graph.**

```
┌─────────────────────────────────────────────────┐
│                  Your Vault                      │
│                                                  │
│  ┌──────────────┐    ┌────────────────────────┐  │
│  │  Your Brain   │    │   Claude's Brain       │  │
│  │               │    │                        │  │
│  │  notes/       │◄──►│  _claude/              │  │
│  │  projects/    │    │    goals.md            │  │
│  │  sources/     │    │    [you]-lens.md       │  │
│  │  people/      │    │    methodology.md      │  │
│  │  self/        │    │    memory/             │  │
│  │  ...          │    │    ...                 │  │
│  └──────────────┘    └────────────────────────┘  │
│                                                  │
│  _review/ ← proposals flow here for your review  │
│                                                  │
└─────────────────────────────────────────────────┘
```

## What is corrhi?

Every Claude session starts from zero. It doesn't know your projects, your preferences, or what you talked about yesterday. And most people's knowledge — years of notes, ideas, bookmarks, conversations — rots in scattered apps they'll never search again. These two problems are the same problem.

corrhi solves both. It's an Obsidian vault (your second brain) and Claude Code (your AI coworker) sharing one knowledge graph. You capture ideas, Claude organizes them. You review proposals, Claude learns from your corrections. Between sessions, Claude runs maintenance — finding connections you missed, flagging stale projects, preparing next steps. Each session picks up where the last one left off.

The name comes from **mycorrhiza** — fungal networks that connect tree roots underground, sharing resources and signals so the whole forest thrives. Claude is the mycelium. You are the tree.

## What makes it different

| | corrhi | Other "second brain" repos |
|---|---|---|
| **Built for** | Non-programmers | Developers |
| **Memory** | Correction-driven — Claude learns from every edit you make | Static instructions that never evolve |
| **Session continuity** | Open/close protocols, goals.md handoff, multi-session persistence | Every session starts cold |
| **Human + AI boundary** | Clear: your brain (vault) + Claude's brain (_claude/), one graph | AI writes directly into your notes |
| **Processing framework** | DRC: Discover, Reflect, Create — a methodology, not just folders | Folders with no workflow |
| **Autonomy** | Scheduled background work (reweave, health checks, research) | Manual only |
| **Provenance** | Every behavioral rule traces to a real correction over months of use | Designed in a weekend |

## Who this is for

- People who use Claude (or want to) and aren't programmers
- People who want a second brain but won't maintain one manually
- People who want their AI to actually learn from them over time

## Prerequisites

- **macOS** (Windows/Linux support planned)
- **[Claude Code](https://claude.ai/code)** CLI installed
- **[Obsidian](https://obsidian.md)** installed
- **Claude Pro** plan minimum ($20/mo). Claude Max recommended for Tier 3 autonomy.

## Quick Start

```bash
# 1. Open Terminal (Cmd+Space, type "Terminal", press Enter)

# 2. Clone and set up
git clone https://github.com/awhynotproduction/corrhi.git
cd corrhi
./setup.sh

# 3. Open Obsidian → "Open folder as vault" → select your vault folder

# 4. Start your first session
c
# Claude will greet you and run /onboard to get to know you
```

Already have Claude Code running? Just say: *"Set up corrhi for me — clone from github.com/awhynotproduction/corrhi"*

## Three Tiers

Pick the level that fits. You can always upgrade later.

### Tier 1: Knowledge System (10 min)
Vault structure, templates, CLAUDE.md instructions, DRC methodology. A working second brain with AI-powered organization.

### Tier 2: Memory + Learning (20 min)
Everything in Tier 1, plus: Claude's brain directory, correction-driven learning loop, hooks (auto-commit, YAML validation, session start/stop), and all skills (/review, /open-session, /close-session, /reweave, /vault-health, /tune-claude, /process-inbox).

### Tier 3: Full Autonomy (30 min)
Everything in Tier 2, plus: autonomous background execution engine (reweave, health checks, research between sessions), credit pacing, remote access via claude.ai/code from your phone. Requires Claude Max plan.

## Daily Rhythm

**Morning.** Type `c` in Terminal. Claude gives you a 3-line check-in: what happened overnight (autonomous work), what's most urgent, one question to get moving.

**Throughout the day.** Brain dump whenever an idea hits — voice dictation, quick note, photo of handwritten notes. Don't organize. Just capture.

**Working session.** Say "let's work on [project]." Claude pulls full context — status, milestones, next actions, related ideas — and you collaborate.

**Review.** Type `/review`. Claude shows you proposals one at a time. Approve, reject, or revise in your own words. This is the reflection practice — nothing enters your vault without your voice.

**End of day.** Type `/close-session`. Claude saves state, commits changes, logs what happened.

**Between sessions.** Claude runs maintenance — finding new connections, checking vault health, processing captures, preparing research. You see the results next morning.

## Philosophy: Discover, Reflect, Create

Modern life traps people in endless Discovery (scrolling, consuming) without completing the loop. corrhi completes it.

**Discover** — Take the world in. Capture ideas, conversations, sources, experiences. Claude organizes what you capture.

**Reflect** — Process what you've taken in. Claude proposes atomic notes with connections. You review, edit in your own words, approve or reject. The editing IS the reflection.

**Create** — Put something into the world. Claude supports with research, drafts, logistics, tools. Everything links back to the ideas that inspired it.

The system is a creative metabolism: discover = ingest, reflect = digest, create = grow.

## Documentation

- [Quick Start Guide](docs/quickstart.md) — Visual walkthrough for non-programmers
- [Core Concepts](docs/concepts.md) — DRC, two-brains architecture, learning loop
- [Adoption Tiers](docs/tiers.md) — Detailed guide for each tier
- [Daily Rhythm](docs/daily-rhythm.md) — What a full day looks like
- [Architecture](docs/architecture.md) — System design deep dive
- [Troubleshooting](docs/troubleshooting.md) — Common issues and solutions

## Contributing

corrhi was built for non-programmers, maintained by AI. If you find a bug or want a feature, [open an issue](https://github.com/awhynotproduction/corrhi/issues). See [CONTRIBUTING.md](CONTRIBUTING.md) for details.

## Credits

Built by [Tony Chen](https://awhynot.com) / [aWhyNotProduction](https://awhynot.com). Evolved through months of daily use with [Claude Code](https://claude.ai/code) by Anthropic.

Named after [mycorrhizal networks](https://en.wikipedia.org/wiki/Mycorrhizal_network) — fungal systems that connect trees underground into one thriving forest.

## License

[MIT](LICENSE)
