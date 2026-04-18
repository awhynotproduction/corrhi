---
name: reweave
description: Comprehensive vault maintenance — connections, health, graph analysis, memory hygiene
user-invocable: false
---

# Reweave — Vault Maintenance Pass

One skill for all vault maintenance. Runs monthly via autonomous engine. Absorbs former vault-health, memory-decay-sweep, and reweave skills.

**Core principle: FLAG, don't delete.** Seeds can sit untouched for years — that's by design. All archive/delete proposals go to `_review/`. Notes sitting dormant is fine.

---

## Section 1: Vault Health (stats + structural integrity)

### 1a. Stats
- File counts per folder: `obsidian files vault=Rhizome folder=X total` for capture, notes, projects, sources, people, self, lists, maps, _review, _agent
- Tag distribution: `obsidian tags vault=Rhizome counts sort=count`
- Property distribution: `obsidian properties vault=Rhizome counts sort=count`
- Capture backlog: count files in `capture/` where `processed: false`
- Proposals pending: `obsidian files vault=Rhizome folder=_review total`

### 1b. Graph health
- Orphans: `obsidian orphans vault=Rhizome` — notes nothing links to
- Dead ends: `obsidian deadends vault=Rhizome` — notes that link to nothing
- Broken links: `obsidian unresolved vault=Rhizome counts` — wiki links pointing to non-existent files
- Map coverage: cross-reference orphan list against map links — are orphans reachable from any map?

### 1c. Frontmatter validation
- Spot-check files missing required fields (created, tags, type)
- Projects missing status + priority
- Sources missing media + status
- People missing role + last_contact

### 1d. Stale projects
- Read each project file, check modification date
- Flag projects with no activity in 2+ weeks (but do NOT auto-archive)

---

## Section 2: Connection Discovery (backward pass)

### 2a. Five Dimensions
1. **Terminology updates:** Have newer notes introduced terms that apply to older notes?
2. **New cross-links:** Do recently added notes connect to older notes that predate them?
3. **Superseded content:** Has any note been effectively replaced by a newer, better version?
4. **Structural reorganization:** Should any notes be split, merged, or moved?
5. **Emergence detection:** Do clusters of notes suggest an unwritten "parent" concept?

### 2b. Graph-Level Connection Finding
- **Clusters:** `obsidian tags vault=Rhizome name=X verbose` — identify dense subgraphs
- **Bridges:** Notes in backlinks of multiple clusters but not sharing tags — cross-domain connectors
- **Triadic closures:** If A→B and B→C but not A→C, suggest the link. Prioritize where A and C share tags or folder. Scope: notes/, projects/, self/ only.

### 2c. Steps
1. Read `dashboard.md` (vault root) for current priorities
2. Find recent notes modified in the last 2 weeks (git log or file dates)
3. For each recent note, use CLI to find connection candidates:
   - `obsidian backlinks vault=Rhizome path=X` — who already links here?
   - `obsidian tags vault=Rhizome name=TAG verbose` — who shares tags?
   - `obsidian search:context vault=Rhizome query=KEYWORD` — who mentions related concepts?
   - Check source→people links (person recommended source)
   - Check people→source links (source discussed in interaction)
   - Check `sparked_by` attribution on atomic notes
4. Use orphan/dead-end lists as priority targets
5. **Auto-execute:** Add new wiki links between existing notes, update maps
6. **Propose (to _review/):** Merges, splits, new concept notes, structural changes
7. Include `_agent/memory/` files in scope — memory files referencing vault notes should be checked for new cross-links

### 2d. Rules
- Quality over quantity — 3 meaningful new links > 20 trivial ones
- If emergence detected (a concept tying 3+ notes together), propose a new note for it

---

## Section 3: Graph Analysis (vault-graph.py)

Run `python3 ~/.claude/scripts/vault-graph.py` if the last report in `_agent/archive/graph-report-*.md` is >7 days old.

Use the graph report to inform Sections 1-2:
- **Hubs** (most-connected notes) — structural observation, not hierarchy. Rhizome is non-hierarchical.
- **Bridges** (cross-cluster connectors) — notes linking separate communities
- **Anti-cramming check:** Flag notes with excessive outgoing links (>20) that may be trying to cover too much
- **Anti-thinning check:** Flag notes with <2 connections that may be too isolated or under-linked
- **Community detection:** Identify natural topic clusters via Leiden algorithm
- **Source orphans:** Completed sources with no `sparked_by` backlinks from atomic notes
- **Triadic closures:** Use INFERRED edges from the graph report to prioritize connection work

Edge confidence tags in the report:
| Tag | Meaning |
|-----|---------|
| EXTRACTED | Explicit wiki-link in file body |
| AMBIGUOUS | Wiki-link target doesn't exist |
| INFERRED | Triadic closure / shared tags suggest connection |

---

## Section 4: Memory Hygiene

### 4a. Staleness check
- Flag memory files in `_agent/memory/` not modified in 90+ days
- Flag memory files with `access_count: 0` older than 30 days
- Check for broken wiki-links in memory files or memory files missing wiki-links entirely

### 4b. Memory-vault alignment
- Do memory files reference vault notes that no longer exist?
- Do memory `project_*` files reference projects whose status has changed?
- Are any behavioral corrections in memory files redundant with AGENTS.md rules?

**Output:** Flag stale/broken memories. Do NOT auto-archive. Propose via `_review/`.

---

## Section 5: QMD + Node Health

### 5a. Node + QMD upgrade
Node is pinned (`brew pin node`) so random `brew upgrade` runs don't break qmd. Reweave owns the intentional upgrade cycle. Every run:

```bash
# 1. Unpin, upgrade, re-pin
brew unpin node && brew upgrade node && brew pin node

# 2. Rebuild qmd's native module for the new Node
cd /opt/homebrew/lib/node_modules/@tobilu/qmd/node_modules/better-sqlite3 && \
rm -rf build && npx --yes node-gyp rebuild

# 3. Verify
qmd status
```

If step 2 fails, check `_agent/memory/reference_qmd_rebuild.md` for troubleshooting. If brew says node is already up to date, skip steps 2-3.

### 5b. QMD index status
Report only — do NOT run reindex. The `qmd-reindex` task in agent-todos.md owns index updates.

- When was the last `qmd embed` run? (check autonomous log or file dates)
- Estimate drift: how many files modified since last embed?
- If drift is significant, note it in the report (the next qmd-reindex run will fix it)

---

## Output

Save full report to `_agent/archive/reweave-report-[date].md`

```
Reweave Report — [date]

## Vault Health
Notes: [count] (capture: X, notes: X, projects: X, ...)
Graph: [orphans] orphans, [deadends] dead ends, [unresolved] broken links
Capture backlog: [count] | Proposals pending: [count]

### Issues
- [broken links, top 5]
- [orphan notes, top 5]
- [dead-end notes, top 5]
- [stale projects, 2+ weeks inactive]
- [frontmatter errors]

## Connections Added
- [list of new links added with brief rationale]

## Graph Analysis
- Hubs: [top 5 most-connected]
- Bridges: [cross-cluster connectors]
- Anti-cramming flags: [notes with >20 outgoing links]
- Communities: [topic clusters found]

## Memory Health
- [stale memory files]
- [broken memory references]

## QMD Status
- Last embed: [date] | Estimated drift: [N files]

## Proposals Submitted
- [list of _review/ proposals generated this run]
```

Write findings to `_agent/autonomous-results.md` under `## Pending Review` with date header.
Update `_agent/goals.md` with reweave summary.
