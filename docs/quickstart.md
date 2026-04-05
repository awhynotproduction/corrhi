# Quick Start Guide

## What You Need

1. **A Mac** (corrhi uses macOS-specific features for automation)
2. **Claude Code** — The CLI tool from Anthropic. Install at [claude.ai/code](https://claude.ai/code)
3. **Obsidian** — Free note-taking app. Download at [obsidian.md](https://obsidian.md)
4. **A Claude account** — Free works for Tier 1. Pro ($20/mo) recommended for Tier 2+.

## Setup (5 minutes)

### Step 1: Open Terminal

Press `Cmd + Space`, type "Terminal", press Enter.

### Step 2: Clone and run setup

Copy and paste these two lines:

```bash
git clone https://github.com/awhynotproduction/corrhi.git
cd corrhi && ./setup.sh
```

The script asks 4 questions:
- Your name
- One sentence about you
- Where to put your vault (press Enter for default)
- Which tier (1, 2, or 3 — pick 2 if unsure)

### Step 3: Open your vault in Obsidian

1. Open Obsidian
2. Click "Open folder as vault"
3. Navigate to your vault folder (default: `~/Documents/corrhi-vault`)
4. Click Open

### Step 4: Start your first session

Go back to Terminal and type:

```bash
c
```

Claude will greet you and run `/onboard` — a conversation to seed your vault with your projects, interests, and preferences.

## What Just Happened?

You now have:
- An Obsidian vault with organized folders for your knowledge
- Claude Code configured to work with your vault
- A system where Claude remembers you between sessions
- Skills for daily workflows (/review, /open-session, /close-session)

## Next: Your First Real Session

After onboarding, try:
- Brain dump an idea: just type whatever's on your mind
- Ask Claude to process it: "process that as a capture"
- Check your vault in Obsidian — you'll see proposals in `_review/`
- Type `/review` to go through them
