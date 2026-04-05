---
name: vault-health
description: System health check — broken links, orphans, stale projects, frontmatter validation
user-invocable: false
---

# Vault Health

Comprehensive health check on the vault. Run weekly to catch drift.

## Steps

1. **Broken links:** Find all `[[wiki links]]` that point to non-existent files. Report each with the source file.

2. **Orphan notes:** Find notes with zero incoming links (nothing links TO them). Exclude: maps/, lists/, templates/, _claude/ brain files.

3. **Dead ends:** Find notes with zero outgoing links (they link to nothing). Every note should link to at least one other note + one map.

4. **YAML frontmatter validation:**
   - Every note in notes/, projects/, sources/, people/, self/ must have: created, tags, type
   - Projects must have: status, priority
   - Sources must have: media, status
   - People must have: last_contact
   - Report missing fields

5. **Stale projects:** Active projects with no file modifications in 2+ weeks.

6. **Empty required sections:**
   - Projects without any Next Actions
   - Sources without Takeaways (if status = completed)
   - People without any Interaction Log entries

7. **Duplicate detection:** Find notes with very similar titles or content that might be duplicates.

8. **Report as dashboard:**

```
## Vault Health — [date]

| Check | Status | Count |
|-------|--------|-------|
| Broken links | ... | X |
| Orphan notes | ... | X |
| Dead ends | ... | X |
| Missing frontmatter | ... | X |
| Stale projects | ... | X |
| Empty sections | ... | X |
| Possible duplicates | ... | X |

### Details
[List specific issues for each category]
```

9. Write report to `_review/task-vault-health-[date].md` as a project-task.

## Rules
- Run weekly (scheduled via claude-todos.md)
- Use Obsidian CLI for graph queries if available, fall back to grep
- Don't auto-fix issues — report them for the user to decide
- Prioritize actionable items (broken links, stale projects) over cosmetic issues
