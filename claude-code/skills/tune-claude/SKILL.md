---
name: tune-claude
description: Synthesize corrections from approval-diffs into the decision lens and memory
user-invocable: false
---

# Tune Claude

Synthesize accumulated corrections into actionable patterns. This is how Claude gets smarter over time.

## Steps

1. Read `_agent/approval-diffs.md` — the raw correction log
2. Count diffs. If fewer than 10, skip (not enough signal yet).

3. **Cluster corrections** into patterns:
   - Group related corrections (e.g., "Claude keeps being too verbose" = 1 cluster)
   - Name each cluster with a clear behavioral pattern
   - Count frequency — how many diffs belong to each cluster?

4. **For each cluster, decide tier:**
   - **Behavioral rule** (agent should DO this differently every time) → Add to ~/AGENTS.md Behavioral Rules
   - **Memory file** (context agent should KNOW) → Create/update `_agent/memory/feedback_*.md`
   - **Lens update** (how the user thinks/decides) → Update `_agent/[user]-lens.md`

5. **Update [user]-lens.md:**
   - Add new decision patterns
   - Update communication preferences
   - Note what matters most to the user

6. **Promote behavioral rules** to ~/AGENTS.md if:
   - The same correction has appeared 3+ times
   - It's about tool selection, communication style, or a "never/always" pattern
   - False positives are cheap (adding an unnecessary rule is better than repeating a mistake)

7. **Clear processed diffs** from approval-diffs.md (archive the raw text to _agent/archive/)

8. **Log the tune:**
   - Date, number of diffs processed, clusters identified, promotions made
   - Append to a brief log at the end of approval-diffs.md

## Rules
- Run when 10+ diffs accumulate (condition-based, not scheduled)
- Use Opus model for synthesis quality
- Corrections from ALL interaction types matter (not just proposal edits)
- The lens should stay under 100 lines — synthesize, don't accumulate
- When promoting to AGENTS.md, include the WHY (what failure prompted this rule)
