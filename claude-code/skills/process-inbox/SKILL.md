---
name: process-inbox
description: Process unprocessed capture items through the DRC pipeline
user-invocable: false
---

# Process Captures

You are processing Tony's capture items through the Discover → Reflect pipeline. Use Obsidian CLI for discovery and verification (commands in AGENTS.md).

## Steps

1. **Scan captures:** Read the vault's `capture/` folder (including `capture/thoughts/` subfolder) and list all files where `processed: false` in frontmatter.

2. **For each item, Classify and File (Discover phase):**
   - Identify type: project to-do | new insight | misc debris | idea seed | reference | list update | source mention | people interaction
   - **Dedup check (CLI):** Before creating anything new, run `obsidian search:context vault=Rhizome query=KEY_PHRASE` to find existing notes covering the same ground. If overlap exists, enhance the existing note instead of creating a duplicate.
   - **Seedbank dedup (critical):** Also search `seedbank/ideas.md`, `seedbank/art-ideas.md`, `seedbank/income-ideas.md` for concept overlap. Tony keeps seedbanks as single-file inventories of ~300 concepts each — promotion to atomic note happens when he engages with the concept or mentions a similar idea twice. If the new capture echoes a seedbank concept, DO NOT duplicate; either (a) note it as a repeat engagement (signal for promotion), or (b) enrich the existing seedbank bullet in place. Run: `grep -i "KEY_PHRASE" seedbank/*.md` before routing any new `_review/` proposal.
   - Route automatically: to-dos → project next actions, list updates → lists/, references → references/
   - Route to proposal: new insights → _review/, new projects → _review/, priority changes → _review/
   - Rephrase into Tony's voice. Never verbatim paste.

   **Source detection heuristics:**
   - "reading/watched/listening to [title]", "finished/started [title]"
   - Extended thoughts about a named work (book, film, article, podcast, show)
   - URLs matching bookmarks or known sources
   - "[person] recommended [title]" → link both source and person
   - If source exists in `sources/`: update status (auto). If new: propose note in `_review/`.

   **People detection heuristics:**
   - "talked to/met/call with [name] about [topic]"
   - "[name] said/recommended [thing]"
   - Action items involving a named person
   - If person exists in `people/`: append interaction log + update last_contact (auto). If new: propose note in `_review/`.

3. **Source attribution pass:**
   - For new atomic notes, check if insight traces to a source
   - Add `sparked_by: [[sources/X]]` to frontmatter of the note
   - Add link in source's Sparked section

4. **Connect (Reflect phase):**
   - Use `obsidian search:context vault=Rhizome query=CONCEPT` to find related existing notes
   - Add `[[wiki links]]` to related existing notes (both directions)
   - Update relevant verses in `verses/` when a capture meaningfully extends an existing thesis arc (don't create new verses from inbox — those emerge from cluster noticing, not routine processing)
   - Flag if a connection changes a project's direction

5. **Verify** (CLI):
   - `obsidian orphans vault=Rhizome` — confirm no new orphans
   - `obsidian unresolved vault=Rhizome` — confirm no broken links
   - All new/modified notes have valid YAML frontmatter

6. **Mark processed and archive:** Set `processed: true` in capture item frontmatter, then move the file to `capture/archive/`.

7. **Report:** Summarize what was processed, what was auto-filed, what's in _review/ for Tony. Include source and people actions taken.

8. **Update goals:** Write session summary to `_agent/goals.md`.

## Rules
- Read `_agent/methodology.md` for full DRC methodology if unsure
- Always update `dashboard.md` (vault root) if priorities changed
- Claude proposes additional context/connections but does NOT auto-enrich sources with research
- Check existing tag vocabulary (`obsidian tags`) before inventing new tags
