# Corrhi — A Personal Knowledge System with an AI Coworker

> This is an "idea file" in the Karpathy sense: a high-level pattern, intentionally abstract. Paste it into Claude Code (or any capable coding agent) and it will build your specific vault *with* you, through conversation. Don't expect a zip file or a setup script. Expect an interview.

## The premise

Most "second brains" fail because: (a) you capture faster than you process, (b) the AI you use forgets everything between sessions, and (c) letting the AI write into your notes turns your graph into a pile of model output with no authorial voice.

This pattern fixes all three by running **two brains on one graph**:

1. **Your brain** — folders of your words: notes, projects, people, consumed media, journal. The AI never writes here directly.
2. **The AI's brain** — a separate folder (`_claude/` or equivalent) for its persistent memory: session goals, a living model of how you think ("lens file"), methodology, autonomous research output, wiki-linked memory files.
3. **A review bridge** (`_review/`) — a proposal queue between the two. Nothing the AI generates enters your brain until you edit it into your own words and approve it. The editing *is* the reflection practice.

Over time, your corrections become the AI's training signal. Not fine-tuning — a synthesis file ("your lens") updated from a log of every edit you made. Correction-driven, not instruction-driven.

## The loop: Discover, Reflect, Create

Modern life traps people in endless Discovery (scrolling, consuming) without closing the loop. This system closes it.

- **Discover** — You take the world in. Books, films, conversations, museums, experiences, brain dumps scribbled on paper. You capture raw — text, voice, photos of handwritten pages. The agent reads, transcribes, classifies, files the routine stuff, and proposes the substantive stuff to the review queue.
- **Reflect** — The agent breaks brain dumps into atomic ideas (one idea per note), suggests wiki-links to existing notes, and drops proposals into the review queue. You review them in your editor, rewrite in your voice, approve or reject. Every edit you make is logged as a correction signal.
- **Create** — When your hands touch material (writing, art, code, events, fabrication), the agent supports with research, logistics, drafts, tools. Projects link back to the ideas, sources, and people that inspired them, so creation stays rooted in its origins.

Two design principles underneath:

1. **AI enhances, doesn't replace human thinking.** The agent does what you weren't doing at all — filing, tagging, cross-linking, maintaining, contextual search — and acts as a thinking partner to bounce ideas off. But nothing counts unless you can put it in your own words.
2. **Everything is recombination.** Creativity is connecting dots between things you've taken in. The system makes recombination visible by keeping sources, ideas, people, and projects in one graph.

## The primitives

The minimum viable version has:

- **Captures** — raw input (text dumps, voice transcriptions, photographed handwriting). Processed items get archived.
- **Atomic notes** — Zettelkasten-style, one idea per file, heavy wiki-linking. Your words only.
- **Projects** — one file per active project, with milestones and 3–5 next actions. The agent tracks them, not you.
- **Sources** — a consumption log. One file per engaged book, film, podcast, show, article, event, or experience. Media-type prefixed (`book-*`, `film-*`, `event-*`). Your reflections on what you consumed.
- **People** — personal CRM. One file per person with an interaction log. The agent updates this whenever you mention a real two-way interaction (in-person, text, email, call, DM) — never from passive consumption like reading someone's post.
- **Maps** — indexes that link clusters of notes. Navigation, not storage.
- **Self** — identity docs and journal transcriptions. You documenting you.
- **Lists** — living documents (watching queue, words you like, recipes, groceries, misc to-dos).
- **Writing** — your authored or adopted output. Research the agent did for you stays in the AI brain until you deliberately adopt it.
- **AI brain** — goals, lens file, methodology, autonomous output, wiki-linked memory files. The agent's private workspace.
- **Review queue** — the bridge. Proposals live here until you act on them.

Exact folder names and structure: negotiate with the agent during setup. These are the *categories*, not the filenames.

## The autonomy boundary (critical)

The agent **acts without asking** for:

- Filing tasks into existing projects' next actions
- Updating living lists (watching, reading, groceries, misc)
- Cleaning up formatting, adding wiki-links between existing notes
- Updating its own brain files (goals, lens)
- Appending interactions to existing people files + updating last-contact
- Updating source status (want → current → completed)
- Adding source-attribution links to existing notes

The agent **proposes (never auto-executes)** for:

- Creating any new atomic note, project, person, or source file
- Changing project priority, status, or strategic direction
- Archiving or deleting any existing note
- Strategic recommendations
- Extracting atomic ideas from a brain dump
- Flagging something as stale or suggesting reaching out to stale contacts

This boundary is the difference between a useful coworker and a runaway content machine. Enforce it in the root `CLAUDE.md` (or equivalent agent config file).

## Correction-driven learning

When you edit a proposal before approving it, capture the diff. When ~10 diffs accumulate, the agent reviews them and synthesizes patterns into a short **lens file** (`[your-name]-lens.md`, ~100 lines) describing how you think, decide, work, and communicate. This file loads at the start of every session. It is the agent's model of you, and it improves only because you kept correcting its proposals.

Do not fine-tune. Do not let the agent invent its lens from nothing. The lens is distilled from your actions on real proposals.

## Session rhythm

- **Session start.** Agent reads goals + lens, checks the review queue, delivers a 3–6 line PM check-in: what happened since last session, what's time-critical, one question to unblock. Never leave you staring at a blank window.
- **During.** You capture (voice, text, photo). You work on projects. The agent fetches context, drafts, researches, builds tools. You stay in creative flow; it handles filing.
- **Review.** On your schedule (daily, weekly, whenever), open the review queue and go through proposals one at a time. Approve, reject, or rewrite. This is your reflection practice — not bureaucracy.
- **Session end.** Agent saves state into goals, commits the graph, logs what happened. Next session resumes exactly here.
- **Between sessions.** Optional: the agent runs maintenance on a schedule — finds new connections between old notes, flags stale projects, checks link health, processes captures. You see the results next morning.

## Health discipline

Background jobs the agent runs on a schedule or on demand:

- **Reweave** — backward pass. Finds new connections between old notes, suggests merges for duplicates, proposes "you wrote X months ago; does it change in light of Y?"
- **Health check** — YAML frontmatter compliance, broken link detection, orphan hunting, stale project flagging.
- **Tune** — synthesize recent correction diffs into lens file updates.
- **Inbox** — process any unprocessed captures through the classify / file / propose pipeline.

## Search & retrieval

Three tools, each for a different question:

- **Graph structure** (orphans, backlinks, tag counts, unresolved links) → editor CLI with a parsed graph (Obsidian CLI if you use Obsidian).
- **Exact keyword / regex** → Grep.
- **Semantic / conceptual** → an embeddings layer over the vault (e.g., a local QMD-style MCP). Use this when the question is "where have I written about X-like ideas" rather than "where does the literal string X appear."

Never load the whole vault into context. Use targeted reads plus search.

## What the agent should do when this file lands in a fresh session

You — the agent reading this — your job is not to run a setup script. Your job is to interview the human in front of you and build *their* version of this pattern with them. Specifically:

1. Read this entire file and tell the human, in your own words, what you understood.
2. Ask them: What do you make? What are you working on right now? Who are the people in your life you want to keep track of? What have you been reading, watching, thinking about? What frustrates you about how you currently manage information? Do they use Obsidian, another markdown editor, or nothing yet?
3. From their answers, draft a proposed folder structure (using the *categories* above) with names that fit their life — not the names in this file.
4. Draft a starter `CLAUDE.md` at the root of their vault encoding the autonomy boundary, the review pipeline, and the two-brains discipline. Keep it under 100 lines.
5. Draft a starter lens file with whatever they've told you about themselves so far. Mark it as a seed; it will grow.
6. Create the review folder and place your first proposal in it: the proposed structure itself. Let them edit and approve it before you create anything else.
7. Tell them the next step is to capture something — anything — and watch the pipeline run end-to-end.

Do not skip the interview. Do not build a generic vault. The specifics exist to be negotiated.

## Failure modes to watch for

- **Collector's fallacy** — capturing without processing. The review queue is where knowledge becomes yours.
- **Cognitive outsourcing** — letting the agent write your ideas for you. Every note in your brain must pass through your voice.
- **Orphan drift** — notes with no incoming or outgoing links become invisible. Every note links to at least one other and one map.
- **Auto-enrichment temptation** — the agent offering to "fill out" your source notes with web research. Your reflections belong to you. The agent can propose context; it cannot auto-write your takeaways.
- **Schema erosion** — template drift over time. Frontmatter validation is not optional.
- **System-building over doing** — don't spend your creative hours tuning the system. The friction of actual use is what grows it.
- **Verbatim capture** — the agent pasting source material instead of rephrasing into your voice. Atomic notes are your synthesis, not quote fragments.

## Naming note

Two metaphors, one system:

**Corrhi** — the pattern, the repo, the distribution. Shortened from *mycorrhiza*, the fungal networks that connect tree roots across a forest, shuttling nutrients and signals between species. It's the metaphor for the collaboration itself: the agent as mycelium, you as the tree, knowledge flowing between. Corrhi is how the system gets shared.

**Your rhizome** — the thing you actually build. Lowercase. After Deleuze and Guattari's figure for non-hierarchical, networked knowledge structures with no center and no trunk — growth from every node, in every direction. Every user's rhizome looks different. Yours is yours.

You run Corrhi; you have a rhizome. If you want to call either one something else, go ahead — names don't matter, the discipline does.

---

*This is a pattern file, not a product. It was born from months of real use — captures, corrections, reweaves, failures, and the slow crystallization of one person's thinking into a working knowledge metabolism. Your version will look different. That's the point.*
