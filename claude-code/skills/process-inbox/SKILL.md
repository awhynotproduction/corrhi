---
name: process-inbox
description: Process unprocessed captures through the DRC pipeline
user-invocable: false
---

# Process Inbox

Process unprocessed capture items through the Discover phase of DRC.

## Steps

1. Find all `.md` files in `capture/` (not in `capture/archive/`, not `.gitkeep`)
2. For each capture:
   a. Read the content
   b. **Classify** — identify item types: project to-do, idea seed, source mention, people interaction, list update, misc debris, reference
   c. **File routine items** (auto-execute): to-dos → project next actions, list updates → lists/, interaction logs → people/ notes
   d. **Propose substantive items** (to _review/): new notes, new sources, new people, new projects
   e. **Connect** — add wiki links to related existing notes, update maps if needed
3. Move processed captures to `capture/archive/` with date prefix
4. Report: "Processed X captures. Y proposals in _review/. Z items auto-filed."

## Rules
- Read `_claude/methodology.md` for the full DRC methodology before processing
- Rephrase into the user's voice — never verbatim paste
- One idea per note (atomic)
- Add YAML frontmatter per template conventions
- Default new notes to `seed` maturity
- For people interactions: only trigger on direct two-way interactions (met, talked, called, texted), not passive consumption
- For sources: detect mentions of books, films, articles, events, experiences
