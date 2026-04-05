---
name: review
description: Daily review — show proposals from _review/ for the user's approval
user-invocable: true
---

# Review

Show the user the next batch of items from `_review/` for approval. Two types live here:

- **vault-entry** — artifact entering the vault (note, source, person, project). Action: approve/reject/revise.
- **project-task** — work product tied to a project (research done, email drafted, etc.). Action: acknowledge/reject/redirect.

## Steps

1. List all `.md` files in `_review/` sorted by creation date (oldest first)
2. Pick the next 5 (or fewer if less remain)
3. For each item, read the file and present based on type:
   - **vault-entry:** Show the full `## The Note` section exactly as written. No summary, no editing.
   - **project-task:** Show the full content. Flag which project it's tied to.
4. After presenting each item, wait for the user's verdict:
   - vault-entry: **approve**, **reject**, or **revise** (with feedback)
   - project-task: **acknowledge** (done), **reject** (delete), or **redirect** (with new direction)
5. Process immediately:
   - **Approved:** Check git diff for user's edits → log to approval-diffs if edited → create note at destination → delete from _review/
   - **Acknowledged:** Update linked project file → move task to `_claude/archive/`
   - **Rejected:** Delete from _review/
   - **Revise:** Apply feedback, tell user it's ready for re-review
   - **Redirect:** Update task based on new direction, re-present
6. After the batch, report: "X approved, X acknowledged, X rejected, X revised. Y items remaining in _review/."

## Rules
- Present items one at a time, not all at once
- For vault-entry: show the FULL content of `## The Note` — no summaries
- `## Claude's Take` provides context but doesn't move to vault — show it separately if the user wants reasoning
- For project-task: show full content, highlight any "next step" for the user
- If the user says "skip" or "next", move to the next item without processing
