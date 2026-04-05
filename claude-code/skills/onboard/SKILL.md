---
name: onboard
description: First-run calibration — get to know the user and seed their vault
user-invocable: true
---

# Onboard

First-run skill for new corrhi users. Detected automatically when goals.md is empty.

**Two modes — check which path the user arrived on:**
- **Post-setup.sh path** (this file) — vault skeleton already exists from `setup.sh`; run the 5-question seeding interview below.
- **Cold-start path** (see [`cold-start.md`](cold-start.md)) — user pasted `IDEA.md` into a fresh session with no vault, no infrastructure. Full interview + scaffolding required. If there is no `_claude/` folder and no `CLAUDE.md` at any root, route there instead.

## Steps

1. Read MEMORY.md to see what setup.sh already captured (name, identity sentence)
2. Greet the user warmly but briefly. Explain: "I'm going to ask you a few questions to seed your vault. This takes about 10 minutes."
3. Ask these 5 questions conversationally (NOT as a form — ask one, respond, ask the next):

   **Q1:** "What are you working on right now? Any projects, goals, or things you're trying to figure out?"
   → Create project proposals in _review/ for each

   **Q2:** "What are you reading, watching, or into lately?"
   → Create source entries in lists/reading.md or lists/watching.md

   **Q3:** "Who are the key people in your life or work right now? Just first names and how you know them is fine."
   → Create person proposals in _review/ for each

   **Q4:** "What do you want to remember about yourself? Values, principles, things you keep coming back to?"
   → Create a self/ note proposal

   **Q5:** "How do you like to work with AI? Do you prefer direct recommendations or options? Detailed explanations or concise? Should I push back on your ideas or mostly support?"
   → Update [user]-lens.md with communication preferences

4. After all questions, briefly explain the daily rhythm:
   - "Type `c` to start a session. I'll check in with what's happening."
   - "Brain dump anytime — just tell me what's on your mind and I'll organize it."
   - "Type `/review` to go through my proposals for your vault."
   - "Type `/close-session` when you're done."

5. Update goals.md with first session summary
6. Tell the user: "Your vault is seeded. From now on, just type `c` to start a session."

## Rules
- Keep the conversation natural, not robotic
- Don't overwhelm — 5 questions max, accept short answers
- Create proposals in _review/ for substantive content (projects, people, self notes)
- Auto-execute for lightweight items (lists, lens updates)
- If the user seems eager to start working on something specific, cut the onboard short and start working
