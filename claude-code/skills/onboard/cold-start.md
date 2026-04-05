# Cold-start onboarding — for users arriving via IDEA.md

This is the onboarding flow when a user pastes `IDEA.md` into a fresh Claude Code session with **no vault, no setup.sh, no prior infrastructure**. Distinct from the post-setup.sh flow in `SKILL.md`, which assumes the skeleton already exists.

## When to run this

- The user pastes `IDEA.md` (or references it) and asks to "set this up" / "build this" / "do this for me"
- There is no `_claude/` folder and no `goals.md` in the working directory
- There is no Corrhi-style `CLAUDE.md` at any recognizable root

If any of those exist, route to the regular `/onboard` flow in `SKILL.md` — the user already has infrastructure and just needs the light seeding interview.

## Principles for the whole flow

- **Interview first, scaffold second.** Do not create a single folder until you understand the user's life.
- **One question at a time.** Wait for a real answer. Do not batch the interview as a form.
- **Short turns.** No multi-paragraph monologues. This is a conversation, not a lecture.
- **Files only at scaffold time.** During the interview, the agent is a listener — no tool calls unless the user asks a clarifying question that needs one.
- **Mirror the user's language.** If they call their work "practice," don't force "projects." If they say "people," don't say "CRM."
- **Cut short if they get antsy.** Eager users can fill gaps later. Don't hold anyone hostage to the full script.

---

## Phase 1 — Orient (1 message)

When the user pastes IDEA.md and signals they want it set up:

> I read it. Before I build anything I want to understand who you are and what you're working on — the vault should fit your life, not the other way around. Five or six questions, about ten minutes. Sound good?

Wait for assent. If they say "skip the questions, just do it" — push back once:

> I can, but the system is mostly worthless without starting signal about you. Even short answers help the lens file learn faster. Still skip?

If they insist, use minimal defaults and flag that the lens file will start empty and grow slowly from corrections.

---

## Phase 2 — Interview (5–6 questions, one at a time)

Ask each question, let them answer, respond briefly (one or two lines acknowledging what they said and maybe reflecting it back), then ask the next. Do not ask Q2 until Q1 is answered.

**Q1 — What you make.**
> What do you make, or what are you trying to make more of? Art, writing, software, research, a business, a family life, a practice you're building — however you'd describe it.

*Listening for:* primary identity, medium(s), career stage, shape of the work.

**Q2 — Active projects.**
> What are the three to seven things that are actually alive for you right now? Not everything on your list — just what you'd work on if you opened your notes today.

*Listening for:* project names, rough scope, any hard deadlines.

**Q3 — People.**
> Who are the people you want to keep track of? Partners, collaborators, mentors, family, clients — just first names and how you know them is fine. Don't try to be complete.

*Listening for:* 3–15 names, roles, any recent-interaction mentions.

**Q4 — Sources in flight.**
> What are you reading, watching, listening to, or chewing on lately? Anything you'd want to remember your thoughts about.

*Listening for:* books, films, articles, podcasts, exhibitions, conversations.

**Q5 — Current notes situation.**
> Where do your notes currently live? Obsidian, Apple Notes, a paper notebook, nothing, scattered across five apps — whatever the real answer is.

*Listening for:* migration scope, editor choice, whether this is a first vault or a reset.

**Q6 — Working style.**
> Last one. How do you like to work with an AI coworker? More direct or more options? Concise or detailed? Should I push back on your ideas or mostly support? And — anything that's bugged you about AI assistants in the past?

*Listening for:* communication preferences, prior corrections, friction points. **This seeds the lens file directly.** Q6 answers are the most valuable input to day-one lens quality — don't rush it.

**Optional Q7 (only if it seems natural):**
> What should the system be called for you? The defaults are *Corrhi* for the project itself and *your rhizome* for your personal graph, but you can rename either.

---

## Phase 2.5 — Migration (only if Q5 surfaced existing content)

If Q5 revealed the user has real existing notes — Notion workspace, Apple Notes, an existing Obsidian vault, scattered markdown docs, a folder full of Google Docs exports — do NOT skip to scaffold. Ask one follow-up before building anything:

> You mentioned [source]. Before I build an empty vault, do you want to pull that in so your new system starts with actual content? Or should we start fresh and you'll add things as you work?

If they say fresh start → go to Phase 3.

If they say pull it in → run the branch below that matches their source. **All branches share three rules:**

1. **Transform, don't copy.** Migration is structural, not clerical. A flat Notion task list does not become a flat vault list — it becomes `## Next Actions` (3-5) + `## Backlog` (the rest). A Milanote board doesn't become one markdown file — it becomes a project file plus atomic notes plus source links. The whole point of migrating is that the new structure teaches something the old one didn't.
2. **Dedup before proposing.** If the interview already surfaced a project/person/source, don't create a duplicate — merge into the existing seed.
3. **Throttle to ~10 proposals per batch.** Never dump 200 proposals into `_review/` at once. The review queue is the bottleneck; overwhelm kills the habit. Stage the rest in `_claude/migration-queue/` and release in batches as the user clears review.

### Branch A — Notion

User provides a Notion workspace export (.zip of markdown + CSVs).

1. Unzip to a temp location. Walk the tree.
2. For each top-level page: classify as project, source, person, reference, or debris.
3. For databases (CSVs): classify the database purpose — tasks? contacts? reading list? — and map to the corresponding vault folder (projects, people, lists/reading.md, etc.).
4. **Flat-to-two-tier transformation:** Any task list with 10+ items gets collapsed into `## Next Actions` (curate top 3-5 from context clues like "urgent," "this week," recent edit dates) + `## Backlog` (the rest). This is non-negotiable. See `feedback_notion_overwhelm.md` for why — flat lists paralyze.
5. Dedup: match titles against interview Q2/Q3 answers before creating anything new.
6. First batch: propose the top 10 most substantive items. Rest stages in `_claude/migration-queue/notion/`.
7. Tell the user: "I pulled your Notion export. 10 proposals are in `_review/` for you to walk through. Another [N] are staged — I'll release them in batches of 10 as you clear review. Don't try to do it all in one sitting."

### Branch B — Apple Notes (macOS only)

Reference the existing `/iphone-notes` command pattern (see `~/.claude/commands/iphone-notes.md` in the reference implementation):

1. Query `~/Library/Group Containers/group.com.apple.notes/NoteStore.sqlite` directly via SQLite.
2. Extract real titles from `ZICNOTEDATA` protobuf blobs (first line after gzip decompress) — NEVER use `ZSNIPPET` as title, it's the body preview and skips the first line. This is a documented Apple schema quirk.
3. Size-based chunking: notes >20k chars stage for Opus processing (one at a time, later); notes <20k atomic-extract in this session.
4. Images: thumbnails are available at `Previews/` paths; full-res requires Notes.app to be open — tell the user to keep Notes open during this phase.
5. Dedup: match titles against interview answers.
6. First batch: 10 proposals, rest staged in `_claude/migration-queue/apple-notes/`.
7. Requires auto-approve permission mode (not "don't ask").

### Branch C — Existing Obsidian vault or markdown folder

Easiest case — content is already in markdown.

1. Ask: "Do you want me to adopt your existing vault in place (add `_claude/`, `_review/`, and the Corrhi schema on top of your current folders) or restructure into the Corrhi layout?" Default to **adopt in place** unless they explicitly want a reorg. Don't rewrite folder structures without permission.
2. Read the existing YAML frontmatter (if any). If notes have no frontmatter, add minimal frontmatter in a single pass and log every file touched.
3. Build `_claude/` alongside existing folders. Seed the lens file from Q1/Q6 plus any `about.md` / `self.md` / `readme.md` that already exists in the vault.
4. Scan existing notes for orphans, broken links, duplicates — but don't fix them. Instead, propose a first `/reweave` pass as the user's first real task after onboarding.
5. No migration queue needed — the content is already in place.

### Branch D — Scattered filesystem (Google Docs exports, folder of text files, etc.)

1. Ask the user to point at the root folder(s).
2. Glob for markdown, text, and common document formats (`.md`, `.txt`, `.rtf`, `.docx`). Flag `.docx` as needing conversion — offer pandoc if available, otherwise skip and queue.
3. Sample 10 random files and classify to get a sense of the content distribution. Report back: "Looks like about 40% brain dumps, 30% project notes, 20% source annotations, 10% junk. Sound right?"
4. Once the user confirms the distribution, run classification over the full set into five buckets: atomic-note candidates, project files, source notes, person mentions, debris.
5. Propose top 10 to `_review/`, stage the rest in `_claude/migration-queue/scattered/`.

### After any branch runs

- Update `_claude/goals.md` with: migration source, total items imported, items staged in queue, items in first review batch.
- Tell the user explicitly: "Migration is not done when this session ends. The staged queue releases in batches as you clear review. Budget 10-15 minutes a day for review during the migration period — usually 1-2 weeks, not one session."
- Proceed to Phase 3 (scaffold), but skip the folder creation steps that migration already handled.

---

## Phase 3 — Scaffold (agent acts)

Build the minimum viable structure. Do NOT populate content yet. The structure itself becomes the first proposal.

1. **Pick a vault path.** Ask where they want it to live. Default suggestions: inside their existing Obsidian sync folder if they use Obsidian, otherwise `~/Documents/<name>`. Never put it somewhere the user didn't confirm.

2. **Create folders** (adapt names to the language they used in the interview — these are *categories*, not prescriptions):
   - `capture/`
   - `notes/`
   - `projects/`
   - `sources/`
   - `people/`
   - `maps/`
   - `lists/`
   - `self/`
   - `writing/`
   - `templates/`
   - `_review/`
   - `_claude/` with subfolders `memory/`, `research/`, `archive/`

   Drop a one-line `README.md` in each explaining its purpose in plain language. This keeps the empty vault legible before any note exists.

3. **Write the root `CLAUDE.md`** — adapt from IDEA.md's premise, methodology, autonomy boundary, and session rhythm. Under 100 lines. Reference the lens file at `_claude/<firstname>-lens.md`.

4. **Seed the lens file** at `_claude/<firstname>-lens.md` using Q1 and Q6 answers:
   - *Preferences and identity* — what they make, medium, how they described themselves
   - *Communication style* — direct vs options, concise vs detailed, pushback vs support
   - *Prior-AI frustrations* — anything they named in Q6
   - Mark the file as a seed that will grow through `/tune-claude` after the first 10 correction diffs accumulate

5. **Write `_claude/methodology.md`** — the full DRC loop and autonomy rules, adapted from IDEA.md's longer-form content.

6. **Create `_claude/goals.md`** with three sections:
   - **Pick up next session:** "First real capture — run the pipeline end-to-end"
   - **Projects (seeded from Q2):** one line per project they named
   - **People (seeded from Q3):** one line per person they named

Do NOT create project files, people files, source files, or atomic notes yet. Those come through the review queue.

---

## Phase 4 — First proposal (the structure itself)

Put the scaffold decision into `_review/` as the user's first proposal. This teaches the review discipline by using it immediately.

Create `_review/scaffold-proposal.md` with:
- YAML frontmatter: `proposal_type: scaffold`, `created: <today>`, `status: pending`
- `## What I built` — list folders, CLAUDE.md, lens seed, goals seed
- `## Things I assumed — please correct` — every default picked without strong signal: folder names, vault path, lens wording, anything guessed
- `## How to review` — "Open this in your editor, edit anything that feels wrong, either approve at the top (`status: approved`) or leave notes in `## Feedback` and I'll revise."

Tell the user where the file is. Wait for them to review. When they come back with edits, apply them. This is their first end-to-end review cycle — walk them through the diff capture so they understand it's how the lens learns.

---

## Phase 5 — First real capture

Once the scaffold is approved, transition:

> The shape is yours. Now let's run one real capture end-to-end so you see how the pipeline feels. Tell me anything that's on your mind right now — a thought, a conversation you had, something you've been chewing on. Don't edit. Just brain-dump.

When they do:
1. Create a raw capture file in `capture/` with their words verbatim.
2. Classify what's in it (ideas, people, sources, tasks, debris).
3. Auto-execute the routine stuff — file a task to a project, append an interaction to a person log, update a living list.
4. Drop substantive items into `_review/` as atomic note proposals.
5. Walk them through what you did, file by file, link by link. Show them the classification so they learn the taxonomy.
6. Tell them: "The proposals are in `_review/`. Open them, rewrite anything that isn't quite your voice, approve or reject. Every edit you make teaches me how you think."

---

## Phase 6 — Handoff

When the first capture → review cycle is complete:

> You're set up. Daily rhythm from here:
> - Type `c` to start a session. I'll give you a short check-in and we'll go.
> - Brain dump whenever — I'll route the pieces.
> - Type `/review` when you want to process proposals.
> - Type `/close-session` when you're done.
>
> The system gets sharper the more you correct me. See you tomorrow.

Update `_claude/goals.md` with a session summary and set "Pick up next session" to whatever the user signaled next. Exit.

---

## Exit conditions (any of these cut the flow short)

- User explicitly asks to stop or says "just work on X instead" → skip remaining interview, seed with what you have, return to onboarding opportunistically in later sessions
- User is pressed for time → do Q1, Q2, Q6 only, scaffold minimally, defer first capture to next session
- User gets frustrated → stop interviewing, ask what's wrong, address it. Do not push through

## Hard rules for the agent running this

- **Never invent answers the user didn't give.** The lens file must be signal-sourced, not hallucinated. If a section has no signal, leave it empty with a comment like `<!-- grows through /tune-claude -->`.
- **Never write content into the user's notes folders during onboarding.** Only folder structure, READMEs, the root `CLAUDE.md`, the `_claude/` brain files, and the review queue.
- **Never skip the first-proposal step.** Even if the scaffold seems obvious. The review discipline has to be felt, not read about.
- **Never promise persistence beyond what the system delivers.** The agent forgets between sessions; disk is the source of truth. Say so explicitly if the user seems to expect more.
- **Never mass-create project, person, or source files from Q2/Q3 answers.** Those go into `goals.md` as seeds only. Real files get created later, through the review queue, as the user actually works.
