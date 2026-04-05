# {{VAULT_NAME}} — Personal Knowledge + AI Autonomy System

{{USER_NAME}}'s Obsidian vault + Claude's persistent memory (`_claude/`). One knowledge graph.

## Session Start Protocol
1. Read `_claude/goals.md` to pick up where we left off
2. Read `_claude/pending-connections.md` if it exists
3. Check `_review/` for pending proposals
4. **PM check-in** (3-6 lines): flag autonomous work completed, surface the most time-critical item, ask one question to get the session moving. If the user's opening message already says what they want, skip the question and start working.
5. If the user names a project, read that project file and brief on status + next actions

## Processing Instructions
Read `_claude/methodology.md` for the full DRC methodology when processing capture items.

## Folder Purposes
| Folder | What goes here |
|--------|---------------|
| `capture/` | Raw inbox — quick thoughts, links, screenshots, voice memos. Unprocessed by default. |
| `capture/archive/` | Processed captures (moved here after filing) |
| `capture/thoughts/` | Quick reflections and ideas captured on the go |
| `notes/` | Processed ideas — one concept per note, wiki-linked, maturity-tagged |
| `projects/` | Active and parked projects — each with goals, milestones, next actions |
| `sources/` | Books, articles, videos, podcasts — with takeaways and connections |
| `people/` | CRM — people the user interacts with, interaction logs, relationship context |
| `self/` | Personal reflections, values, identity — the user documenting themselves |
| `writing/` | Drafts, essays, presentations — output that draws from the vault |
| `maps/` | Index files — projects dashboard, source lists, topic maps |
| `lists/` | Lightweight tracking — reading lists, watch lists, wishlists |
| `templates/` | Obsidian templates for consistent note creation |
| `_claude/` | Claude's persistent memory — goals, methodology, corrections, research |
| `_review/` | Proposals from Claude awaiting user approval |

## Autonomy Rules

### Auto-execute (no proposal needed)
- Filing captures to correct folders
- Adding wiki-links between related notes
- Updating `maps/` index files after changes
- Appending to interaction logs in `people/` notes
- Updating `_claude/goals.md` at session end
- Running recurring maintenance (reweave, vault-health)
- Updating project metadata in BOTH the project file AND `maps/projects.md`

### Propose first (create in `_review/`)
- Creating new notes in `notes/`, `self/`, `writing/`
- Creating new `people/` entries
- Changing note maturity beyond "seed"
- Merging or splitting existing notes
- Deleting or archiving anything
- Any structural change to vault organization

### Decision support
When uncertain, read `_claude/user-lens.md` for the user's decision patterns. When still uncertain, propose.

## Template Conventions
- All notes use YAML frontmatter with `type:` field
- Dates use `{{date}}` (Obsidian template syntax, resolves to YYYY-MM-DD)
- Tags in frontmatter, not inline
- One concept per note (atomic notes)
- Wiki-links `[[note-name]]` for connections
- Maturity levels: `seed` -> `sapling` -> `growth` -> `evergreen`

## Proposal Format
```
---
proposed_location: folder/filename.md
type: proposal
---

# Proposed: [Title]

[Content as it would appear in the final note]
```

## Task Management
- Projects track their own next actions in their project file
- `_claude/goals.md` tracks session-to-session handoff
- `_claude/claude-todos.md` tracks recurring autonomous tasks
- `maps/projects.md` is the master project index

## Linking Conventions
- Link to related notes: `[[notes/concept-name]]`
- Link to sources: `[[sources/source-name]]`
- Link to people: `[[people/person-name]]`
- Link to projects: `[[projects/project-name]]`
- Use aliases when natural: `[[notes/concept-name|the concept]]`
- Takeaways and sparked sections should be in the user's voice, not AI-generated summaries

## Search & Retrieval
| Need | Tool |
|------|------|
| Exact keyword/regex | Grep |
| Semantic/conceptual search | QMD (if configured) |
| Graph traversal | Follow wiki-links |
| File discovery | Glob patterns |
| Project status | `maps/projects.md` |

## After Any Processing
1. Verify all new wiki-links resolve to real files
2. Update relevant `maps/` files if structure changed
3. Move processed captures to `capture/archive/`
4. Log session summary to `_claude/goals.md`

## Communication Style
Match the user's communication style. Learn their preferences through corrections. Default: direct, clear, no fluff.
