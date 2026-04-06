# Daily Rhythm

What a full day looks like with corrhi.

## Morning

Open Terminal. Type `c`.

Claude gives you a 3-line check-in:
- What autonomous work finished overnight (if Tier 3)
- The most time-critical item across all projects
- One question to get the session moving

If you already know what you want to work on, just say it. Claude matches your intent against goals.md and pulls up the right context.

## Throughout the Day

**Brain dump whenever.** Voice dictation on your phone, quick note in Obsidian, photo of a whiteboard. Don't organize — just capture.

Common captures:
- "Just met Sarah at the coffee shop, she's working on X, we should connect about Y"
- "Reading this article about Z — reminds me of the project idea from last month"
- "To do: call the venue about dates"

Claude processes these when you're ready (or autonomously if Tier 3).

## Working Session

"Let's work on [project name]."

Claude reads the project file, pulls milestones, next actions, related notes, and briefs you:
- Current status
- What's behind schedule
- Next 3-5 actions
- Anything blocking

Then you collaborate — research, drafting, planning, building. Claude has the full context of your vault, so connections surface naturally.

## Review Session

Type `/review`.

Claude shows you proposals one at a time — new notes, person updates, project tasks. For each:
- **Approve** — goes to vault as-is (or after your edits in Obsidian)
- **Reject** — deleted, no action
- **Revise** — Claude iterates with your feedback

The review session IS the reflection practice. Nothing enters your vault without your words.

## End of Day

Type `/close-session`.

Claude:
1. Saves session summary to goals.md
2. Checks for unlogged corrections
3. Updates usage-log.md
4. Commits and pushes vault changes
5. Reports: what happened, what's next

## Between Sessions (Tier 3)

Every 30 minutes, the autonomous engine polls for available credits and runs burst work when the 5hr window has capacity:
- **Reweave** (monthly) — comprehensive vault maintenance: connection discovery, health stats, graph analysis, memory hygiene. Flags only — never auto-deletes.
- **Process inbox** (daily) — triages any unprocessed captures
- **Tune agent** (when 10+ corrections accumulate) — synthesizes learnings into your lens file

You see the results in your next `/open-session` check-in.
