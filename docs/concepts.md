# Core Concepts

## Two Brains, One Graph

Your corrhi vault has two inhabitants:

**Your brain** — `notes/`, `projects/`, `sources/`, `people/`, `self/`, `maps/`, `lists/`, `writing/`. This is your knowledge. Claude helps organize it, but everything here is in your words, reviewed and approved by you.

**Agent brain** — `_agent/`. Goals, decision lens, memory files, methodology, research, archive. This is the agent's working memory. It reads your brain, maintains its own, and proposes changes through `_review/`.

The two share one knowledge graph. Wiki-links connect ideas across both brains. But the boundary is clear: Claude proposes, you decide.

## Discover, Reflect, Create (DRC)

A framework for how knowledge grows and becomes action.

**Discover** — Take the world in. Read, watch, listen, experience, converse. Capture ideas without worrying about organization. Voice dictation, quick notes, photos of handwritten thoughts. Claude handles the filing.

**Reflect** — Process what you've taken in. Claude proposes atomic notes with connections to your existing knowledge. You review, rewrite in your own words, approve or reject. The editing IS the reflection. Nothing enters your vault without your voice.

**Create** — Put something into the world. Art, writing, events, products, conversations. Claude supports with research, drafts, logistics, and tools. Everything links back to the ideas that inspired it.

Modern life traps people in endless Discovery (scrolling, consuming) without completing the loop. corrhi completes it.

## The Learning Loop

Claude gets smarter the more you use it.

1. **You correct Claude** — edit a proposal, push back on an approach, tell it "no, not like that"
2. **Claude logs the correction** — immediately saved to `approval-diffs.md`
3. **Patterns accumulate** — after 10+ corrections, `/tune-claude` synthesizes them
4. **Decision lens updates** — `[you]-lens.md` captures how you think and decide
5. **Behavioral rules promote** — recurring patterns become standing instructions in `AGENTS.md`

This means Claude's mistakes are one-time. The system evolves through use, not through version updates.

## The Proposal Workflow

Claude never writes directly into your knowledge. Instead:

1. Claude creates a **proposal** in `_review/`
2. You review it (in Obsidian or via `/review`)
3. You **approve** (goes to vault), **reject** (deleted), or **revise** (Claude iterates)

For routine maintenance (formatting, filing to-dos, updating lists), Claude auto-executes. For anything substantive (new ideas, new projects, strategic suggestions), Claude proposes.

## Session Continuity

Every session picks up where the last one left off.

- **`/open-session`** — Claude reads goals.md, checks _review/, gives you a PM-style check-in
- **`/close-session`** — Claude saves state, commits changes, logs what happened
- **`goals.md`** — The handoff file. Last session's summary + what's next

Between sessions, Claude can run autonomous maintenance (Tier 3): finding connections, checking vault health, processing captures, researching next steps.

## Autonomy Rules

| Action | Auto or Propose? |
|--------|-----------------|
| File a to-do into existing project | Auto |
| Format/clean up a note | Auto |
| Add wiki links between notes | Auto |
| Update Maps of Content | Auto |
| Update living lists | Auto |
| Update agent brain files | Auto |
| **Create a new note** | **Propose** |
| **Change project priority** | **Propose** |
| **Create a new project** | **Propose** |
| **Archive or delete a note** | **Propose** |
| **Strategic suggestions** | **Propose** |
