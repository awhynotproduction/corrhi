---
type: claude-brain
purpose: Stable reference — DRC processing methodology
---

# Processing Methodology — Discover, Reflect, Create

## Philosophy

The vault operates on Discover, Reflect, Create — a framework for how knowledge grows and becomes action. Modern life traps people in endless Discovery (scrolling, consuming) without completing the loop. This system completes it.

**Two core design principles:**

1. **AI enhances, doesn't replace human thinking.** Two modes: (a) do what the user wasn't doing at all — filing, organizing, tagging, maintaining, contextual search, and (b) be a thinking partner to bounce ideas off, with the full power of AI and the internet behind the conversation. But nothing counts unless the user can put it in their own words.

2. **Everything is recombination.** Creativity is connecting dots between things you've discovered, putting a circle around a new combination and calling it one thing. The system makes this visible by keeping all sources, ideas, and connections in one graph.

---

## Phase 1: Discover

The input phase. Raw material enters the system.

### Capture
- Everything starts in `capture/` — links, thoughts, screenshots, voice memos, forwarded emails
- Captures are tagged `[capture, unprocessed]` by default
- No filtering at capture time. The goal is zero friction.

### Classify
Determine what type of thing this is:
- **Source** — something created by someone else (book, article, video, podcast, tweet thread)
- **Note** — an idea, observation, or concept (the user's own thinking)
- **Self** — personal reflection, value, identity exploration
- **Person** — someone the user interacted with
- **Project** — an actionable endeavor with goals and milestones
- **Task** — a next action that belongs to an existing project

### File
Move the capture to its correct location:
- Sources -> `sources/` with source template
- Notes -> `notes/` with note template
- Self -> `self/` with self template
- People -> `people/` with person template
- Projects -> `projects/` with project template
- Tasks -> append to the relevant project's Next Actions

After filing, move the original capture to `capture/archive/`.

---

## Phase 2: Reflect

The connection phase. Raw material becomes knowledge.

### Converse
- When processing sources, distinguish between metadata Claude can fill (creator, year, URL, media type) and sections that require the user's voice (takeaways, sparked)
- For completed sources the user has already engaged with, Claude can draft takeaways based on discussion — but the user has final say
- For in-progress sources, leave takeaways and sparked empty for the user to fill

### Track
- Update `maps/projects.md` when project metadata changes
- Update `maps/sources.md` when sources are added or completed
- Update `maps/dashboard.md` with current priorities
- Keep `_claude/goals.md` current at every session end

### Decompose
- Break complex captures into atomic notes (one concept per note)
- Each atomic note gets its own file in `notes/`
- The original capture in `capture/archive/` serves as provenance

### Curate
- Assign maturity levels honestly:
  - `seed` — raw idea, just captured, minimal development
  - `sapling` — some connections made, starting to take shape
  - `growth` — well-developed, multiple connections, tested against other ideas
  - `evergreen` — stable, fundamental, referenced frequently
- Most notes stay at seed or sapling. That's fine. Don't inflate maturity.

### Connect
- Add wiki-links between related notes
- Look for non-obvious connections across domains
- When a connection is uncertain, add it to `_claude/pending-connections.md` for user review
- Sources should link to notes they sparked
- Notes should link to sources that informed them
- Projects should link to relevant notes and sources

### Resurface
- During processing, surface relevant existing notes the user may have forgotten
- "This connects to [[notes/existing-note]] — want me to link them?"
- The goal is making the vault's existing knowledge visible and useful

### Mature
- When new information strengthens an existing note, update it (don't create a duplicate)
- When notes are ready to level up in maturity, propose the change
- When multiple seed notes converge on the same idea, propose a merge

---

## Phase 3: Create

The output phase. Knowledge becomes action.

### Prioritize
- Projects have explicit priority (P1/P2/P3) and status (active/paused/complete)
- `maps/projects.md` is the single source of truth for project status
- When updating priority, update BOTH the project file frontmatter AND `maps/projects.md`

### Make
- `writing/` is for output that draws from the vault — essays, presentations, proposals
- Writing should reference (wiki-link) the notes and sources it draws from
- This creates a visible trail from discovery through reflection to creation

### Share
- When work is ready to share, note it in the project file
- Track what was shared, where, and when

---

## System Health

### Recurring Maintenance
| Task | Frequency | What it does |
|------|-----------|--------------|
| `reweave` | Weekly | Scan for missing wiki-links, orphan notes, broken connections |
| `vault-health` | Weekly | Check for template compliance, empty notes, stale projects |
| `tune-claude` | On condition (10+ diffs) | Synthesize approval-diffs into user-lens patterns |
| `process-inbox` | Daily | Process unprocessed captures |

### Vault Hygiene
- No orphan notes (every note should link to at least one other note)
- No empty notes (if a note has no content, delete or fill it)
- No stale projects (if a project hasn't been touched in 30+ days, flag it)
- No duplicate coverage (before creating, search for existing notes on the topic)

---

## Proposal Format

When Claude needs approval before creating a note:

```
---
proposed_location: folder/filename.md
type: proposal
---

# Proposed: [Title]

[Full content as it would appear in the final note]
```

Place in `_review/`. User reviews in Obsidian or via `/review` command.

---

## Autonomy Rules

| Action | Autonomy Level |
|--------|---------------|
| File a capture to correct folder | Auto-execute |
| Add wiki-links between notes | Auto-execute |
| Update maps/index files | Auto-execute |
| Append to people/ interaction log | Auto-execute |
| Update goals.md at session end | Auto-execute |
| Run recurring maintenance | Auto-execute |
| Create new note in notes/ | Propose |
| Create new self/ entry | Propose |
| Create new writing/ draft | Propose |
| Create new people/ entry | Propose |
| Change note maturity | Propose |
| Merge or split notes | Propose |
| Delete or archive anything | Propose |
| Structural vault changes | Propose |

---

## Failure Mode Mitigations

### Over-organizing
**Risk:** Spending more time organizing than creating.
**Mitigation:** Processing should be fast. If a capture doesn't clearly fit a type, make it a seed note and move on. Perfection is the enemy of a useful vault.

### Under-connecting
**Risk:** Notes exist in isolation, vault becomes a filing cabinet instead of a knowledge graph.
**Mitigation:** Every processing session should add at least one new connection. Reweave catches what was missed.

### AI voice creep
**Risk:** Claude's writing style infiltrates notes that should be in the user's voice.
**Mitigation:** Takeaways, sparked sections, and self/ entries are the user's voice only. Claude can draft for completed sources the user has discussed, but the user always has final edit. For in-progress sources, those sections stay empty until the user fills them.

### Maturity inflation
**Risk:** Notes get upgraded to evergreen without earning it.
**Mitigation:** Evergreen means stable, fundamental, and frequently referenced. Most notes are seeds. That's healthy.

### Proposal fatigue
**Risk:** Too many proposals make the user stop reviewing them.
**Mitigation:** Batch proposals when processing multiple captures. Keep proposals concise. Auto-execute everything that's safe to auto-execute.

### Stale goals
**Risk:** `goals.md` drifts from reality and stops being useful.
**Mitigation:** Update at every session end. If a goal hasn't been touched in two weeks, flag it.

---

## Token Efficiency

### Reading Strategy
- Read `goals.md` and `pending-connections.md` at session start (small files, high value)
- Read project files only when the user names a project
- Search before reading — use grep/QMD to find relevant files rather than reading everything
- For large files, read only the sections you need

### Writing Strategy
- Batch related file updates into single turns
- Update maps/ files after all changes are made, not after each individual change
- Keep proposals concise — full content but no redundant explanation

### Processing Strategy
- Process captures in batches when multiple exist
- Classify all first, then file all, then connect all — don't context-switch per capture
- Use grep to check for existing coverage before creating new notes
