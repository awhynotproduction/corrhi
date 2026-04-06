# Troubleshooting

## Setup Issues

### "command not found: claude"
Claude Code CLI isn't installed or isn't in your PATH. Install from [claude.ai/code](https://claude.ai/code), then restart Terminal.

### "command not found: git"
Install git: open Terminal, type `xcode-select --install`, follow the prompts.

### setup.sh won't run
Make it executable: `chmod +x setup.sh`, then try again.

## Session Issues

### Claude doesn't know who I am
Check that MEMORY.md exists and has your info:
```bash
cat ~/.claude/projects/*/memory/MEMORY.md
```
If empty or missing, re-run setup.sh.

### Claude doesn't see my vault
Check the CORRHI_VAULT environment variable:
```bash
echo $CORRHI_VAULT
```
If empty, restart Terminal (setup.sh added it to your shell config) or set it manually:
```bash
export CORRHI_VAULT="$HOME/Documents/corrhi-vault"
```

### Hooks aren't firing
Verify hooks are installed:
```bash
ls ~/.claude/hooks/
```
Check settings.local.json has hooks configured:
```bash
cat ~/.claude/projects/*/settings.local.json
```

### /review shows nothing
Your `_review/` folder is empty. This is normal for a new vault. Proposals appear after you brain dump content and Claude processes it, or after autonomous sessions run.

## Vault Issues

### Obsidian doesn't show the vault
Make sure you opened the right folder. In Obsidian: Settings > About > Vault path. It should match your CORRHI_VAULT.

### Git commits aren't happening
The auto-commit hook only fires on vault writes/edits within Claude Code. Manual Obsidian edits won't auto-commit. Use Obsidian Git plugin for those, or commit manually.

### Broken wiki links
Run `/reweave` — it checks for broken links, orphan notes, and reports them.

## Tier 3 Issues

### Autonomous sessions aren't running
Check if the launchd agent is loaded:
```bash
launchctl list | grep corrhi
```
Check logs:
```bash
cat /tmp/claude-autonomous-stdout.log
```

### Remote access not showing on phone
1. Verify the session is running: `pgrep -af "claude.*remote-control"`
2. Go to claude.ai/code on your phone and refresh
3. The session should appear as "corrhi"

### Power settings
Verify Mac won't sleep on AC:
```bash
pmset -g | grep sleep
```
Should show `sleep 0` for AC power.

## Getting Help

If something's broken that isn't covered here, [open an issue](https://github.com/awhynotproduction/corrhi/issues).
