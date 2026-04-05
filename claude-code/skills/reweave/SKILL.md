---
name: reweave
description: Backward pass — find new connections, flag stale content, upgrade maturity
user-invocable: false
---

# Reweave

Periodic backward pass through the vault. Find connections that weren't obvious when notes were originally written.

## Steps

1. **Terminology updates:** Scan for outdated terms or renamed concepts. Propose updates.

2. **New cross-links:** For recent notes (last 2 weeks), search for related older notes that should link to them. Propose bidirectional links.

3. **Superseded content:** Find notes that have been replaced or evolved beyond their current text. Flag for update or merge.

4. **Structural reorganization:** Check if any cluster of notes deserves its own Map of Content. Check if existing maps need updating.

5. **Emergence detection:** Look for patterns across notes that suggest a new idea the user hasn't explicitly articulated. Propose as a seed note in _review/.

6. **Maturity check:** Review seed/growing notes.
   - If a seed has gained 3+ connections → propose upgrade to `growing`
   - If a growing note is well-connected and foundational → propose upgrade to `evergreen`

7. **Stale content:** Flag:
   - Active projects with no updates in 2+ weeks
   - Notes marked `growing` with no new connections in 4+ weeks
   - People notes with last_contact > 3 months ago (suggest reaching out)

8. Write results to _review/ as proposals or report directly.

## Rules
- Don't auto-execute link additions — propose them so the user can verify
- Emergence detection is the highest-value output — spend time here
- Keep proposals concise — the user will review many at once
- Run weekly (scheduled via claude-todos.md)
