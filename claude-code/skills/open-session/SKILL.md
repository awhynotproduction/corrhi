---
name: open-session
description: Load context and give the user a PM check-in at session start
user-invocable: true
---

# Open Session

Session start protocol. Run automatically or when the user types /open-session.

## Steps

1. Read `_agent/goals.md` for session continuity (last session summary, pick up next)
2. Check `_review/` for pending proposals (count them)
3. Check `capture/` for unprocessed items (count them)
4. Read `_agent/[user]-lens.md` if doing substantial work this session

5. Deliver a PM check-in (3-6 lines, NOT a briefing deck):
   - Flag any autonomous work completed since last session
   - Surface the most time-critical item or approaching deadline
   - Ask ONE specific question to get the session moving

6. If the user's opening message already says what they want to do, skip the question and start working immediately.

## Rules
- Think sharp chief of staff, not status report
- Never dump a wall of text — 3-6 lines max
- If goals.md is empty (fresh vault), run /onboard instead
- Match the user's energy — if they're brief, be brief
- Surface deadlines proactively (what's at risk this week?)
