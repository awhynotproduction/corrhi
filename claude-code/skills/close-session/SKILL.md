---
name: close-session
description: End-of-session protocol — save state, commit, report
user-invocable: true
---

# Close Session

End-of-session protocol. Saves state so the next session picks up seamlessly.

## Steps

1. **Save session summary to goals.md:**
   - What was accomplished this session
   - What to pick up next session
   - Update active priorities if changed

2. **Check for unlogged corrections:**
   - Review the conversation for any feedback or corrections not yet in approval-diffs.md
   - Log any found corrections immediately

3. **Update usage-log.md:**
   - Add row with date, start/end time (approximate), duration, type (interactive), summary

4. **Git commit + push:**
   - Stage all vault changes
   - Commit with descriptive message
   - Push to remote if configured

5. **Report to user (2-3 lines):**
   - What was done
   - What's queued for next session
   - Any pending items in _review/

## Rules
- Always update goals.md — this is the handoff mechanism
- Never skip the correction check — unlogged feedback is lost feedback
- Keep the report brief — the user is wrapping up, not starting
- If there are uncommitted changes, warn before closing
