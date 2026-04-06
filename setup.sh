#!/bin/bash
# setup.sh — Interactive corrhi setup
# Asks 4 questions, generates all personalized files
# Uses only macOS builtins. Zero dependencies.

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# --- Colors ---
BOLD='\033[1m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m'

echo ""
echo -e "${BOLD}corrhi${NC} — personal knowledge + AI autonomy"
echo -e "Two brains, one graph."
echo ""

# --- Check prerequisites ---
MISSING=""

if [[ "$(uname)" != "Darwin" ]]; then
  echo -e "${YELLOW}Warning: corrhi is designed for macOS. Some features (launchd, sips) won't work on other platforms.${NC}"
fi

if ! command -v git &>/dev/null; then
  MISSING="${MISSING}  - git (install from https://git-scm.com)\n"
fi

if ! command -v claude &>/dev/null; then
  MISSING="${MISSING}  - Claude Code CLI (install from https://claude.ai/code)\n"
fi

if [ -n "$MISSING" ]; then
  echo -e "${YELLOW}Missing prerequisites:${NC}"
  echo -e "$MISSING"
  echo "Install these first, then re-run ./setup.sh"
  exit 1
fi

# --- Question 1: Name ---
echo -e "${CYAN}What's your first name?${NC}"
read -r USER_FIRST_NAME
if [ -z "$USER_FIRST_NAME" ]; then
  echo "Name is required."
  exit 1
fi

USER_LOWER=$(echo "$USER_FIRST_NAME" | tr '[:upper:]' '[:lower:]')

echo ""

# --- Question 2: Identity ---
echo -e "${CYAN}One sentence about who you are (e.g., 'Designer who loves cooking and runs a book club'):${NC}"
read -r USER_IDENTITY
if [ -z "$USER_IDENTITY" ]; then
  USER_IDENTITY="$USER_FIRST_NAME"
fi

echo ""

# --- Question 3: Vault location ---
DEFAULT_VAULT="$HOME/Documents/corrhi-vault"
echo -e "${CYAN}Where do you want your vault? (default: ${DEFAULT_VAULT})${NC}"
read -r VAULT_PATH
if [ -z "$VAULT_PATH" ]; then
  VAULT_PATH="$DEFAULT_VAULT"
fi
# Expand ~ if present
VAULT_PATH="${VAULT_PATH/#\~/$HOME}"

echo ""

# --- Question 4: Tier ---
echo -e "${CYAN}Which tier?${NC}"
echo "  1) Knowledge System (vault + templates + AGENTS.md)"
echo "  2) Memory + Learning (+ brain, hooks, skills, learning loop)"
echo "  3) Full Autonomy (+ autonomous engine, remote access)"
echo ""
echo -e "Pick 1, 2, or 3 (default: 2):"
read -r TIER
if [ -z "$TIER" ]; then
  TIER=2
fi

echo ""
echo -e "${BOLD}Setting up corrhi for ${USER_FIRST_NAME}...${NC}"
echo ""

# ============================================================
# TIER 1: Knowledge System
# ============================================================

# --- Copy vault ---
echo -e "  ${GREEN}+${NC} Creating vault at ${VAULT_PATH}"
mkdir -p "$VAULT_PATH"
cp -R "$SCRIPT_DIR/vault/"* "$VAULT_PATH/" 2>/dev/null || true
cp "$SCRIPT_DIR/vault/.gitignore" "$VAULT_PATH/.gitignore" 2>/dev/null || true
cp "$SCRIPT_DIR/vault/.claudeignore" "$VAULT_PATH/.claudeignore" 2>/dev/null || true
cp -R "$SCRIPT_DIR/vault/.obsidian" "$VAULT_PATH/.obsidian" 2>/dev/null || true

# --- Rename user-lens.md ---
if [ -f "$VAULT_PATH/_agent/user-lens.md" ]; then
  sed "s/\[User\]/${USER_FIRST_NAME}/g; s/{{USER_NAME}}/${USER_FIRST_NAME}/g" \
    "$VAULT_PATH/_agent/user-lens.md" > "$VAULT_PATH/_agent/${USER_LOWER}-lens.md"
  rm "$VAULT_PATH/_agent/user-lens.md"
  echo -e "  ${GREEN}+${NC} Created ${USER_LOWER}-lens.md"
fi

# --- Personalize vault files (replace both placeholder styles) ---
for vfile in "$VAULT_PATH/AGENTS.md" "$VAULT_PATH/_agent/"*.md; do
  [ -f "$vfile" ] || continue
  sed -i '' "s/\[User\]/${USER_FIRST_NAME}/g; s/{{USER_NAME}}/${USER_FIRST_NAME}/g; s/{{VAULT_NAME}}/corrhi/g; s/user-lens\.md/${USER_LOWER}-lens.md/g" "$vfile" 2>/dev/null || true
done

# --- Initialize git ---
if [ ! -d "$VAULT_PATH/.git" ]; then
  cd "$VAULT_PATH"
  git init -q
  git add -A
  git commit -q -m "Initial corrhi vault setup"
  echo -e "  ${GREEN}+${NC} Initialized git repository"
  cd "$SCRIPT_DIR"
fi

echo -e "  ${GREEN}+${NC} Tier 1 complete: Knowledge System"

if [ "$TIER" -lt 2 ]; then
  echo ""
  echo -e "${BOLD}Done!${NC}"
  echo ""
  echo "Next steps:"
  echo "  1. Open Obsidian → 'Open folder as vault' → ${VAULT_PATH}"
  echo "  2. Open Terminal and run: claude"
  echo ""
  exit 0
fi

# ============================================================
# TIER 2: Memory + Learning
# ============================================================

echo ""

# --- Set up Claude Code config ---
CLAUDE_DIR="$HOME/.claude"
mkdir -p "$CLAUDE_DIR/hooks" "$CLAUDE_DIR/skills"

# --- Copy hooks ---
if [ -d "$SCRIPT_DIR/claude-code/hooks" ]; then
  for hook in "$SCRIPT_DIR/claude-code/hooks/"*.sh; do
    [ -f "$hook" ] || continue
    BASENAME=$(basename "$hook")
    cp "$hook" "$CLAUDE_DIR/hooks/$BASENAME"
    chmod +x "$CLAUDE_DIR/hooks/$BASENAME"
  done
  echo -e "  ${GREEN}+${NC} Installed hooks"
fi

# --- Copy skills ---
if [ -d "$SCRIPT_DIR/claude-code/skills" ]; then
  cp -R "$SCRIPT_DIR/claude-code/skills/"* "$CLAUDE_DIR/skills/" 2>/dev/null || true
  echo -e "  ${GREEN}+${NC} Installed skills"
fi

# --- Write home AGENTS.md ---
if [ -f "$SCRIPT_DIR/claude-code/AGENTS.md" ]; then
  sed "s|\[User\]|${USER_FIRST_NAME}|g; s|{{USER_NAME}}|${USER_FIRST_NAME}|g; s|\\\$VAULT_PATH|${VAULT_PATH}|g; s|user-lens\.md|${USER_LOWER}-lens.md|g; s|\[user\]-lens\.md|${USER_LOWER}-lens.md|g" \
    "$SCRIPT_DIR/claude-code/AGENTS.md" > "$HOME/AGENTS.md"
  echo -e "  ${GREEN}+${NC} Created ~/AGENTS.md"
fi

# --- Write MEMORY.md ---
# Find the Claude project memory path
ESCAPED_HOME=$(echo "$HOME" | sed 's|/|-|g; s|^-||')
PROJECT_MEM_DIR="$CLAUDE_DIR/projects/${ESCAPED_HOME}/memory"
mkdir -p "$PROJECT_MEM_DIR"

if [ -f "$SCRIPT_DIR/claude-code/MEMORY.md" ]; then
  sed "s/\[User\]/${USER_FIRST_NAME}/g; s/{{USER_NAME}}/${USER_FIRST_NAME}/g; s|\[vault_path\]|${VAULT_PATH}|g; s|\[user\]-lens|${USER_LOWER}-lens|g; s|\[user\]|${USER_LOWER}|g; s/\[One sentence about who you are — filled in by setup.sh\]/${USER_IDENTITY}/g" \
    "$SCRIPT_DIR/claude-code/MEMORY.md" > "$PROJECT_MEM_DIR/MEMORY.md"
  echo -e "  ${GREEN}+${NC} Created MEMORY.md bootstrap"
fi

# --- Write settings.local.json (hooks config) ---
SETTINGS_DIR="$CLAUDE_DIR/projects/${ESCAPED_HOME}"
mkdir -p "$SETTINGS_DIR"

if [ -f "$SCRIPT_DIR/claude-code/settings.local.json" ]; then
  cp "$SCRIPT_DIR/claude-code/settings.local.json" "$SETTINGS_DIR/settings.local.json"
  echo -e "  ${GREEN}+${NC} Configured hooks in settings"
fi

# --- Set CORRHI_VAULT env var ---
SHELL_RC="$HOME/.zshrc"
if [ -f "$HOME/.bashrc" ] && [ ! -f "$HOME/.zshrc" ]; then
  SHELL_RC="$HOME/.bashrc"
fi

if ! grep -q "CORRHI_VAULT" "$SHELL_RC" 2>/dev/null; then
  echo "" >> "$SHELL_RC"
  echo "# corrhi" >> "$SHELL_RC"
  echo "export CORRHI_VAULT=\"${VAULT_PATH}\"" >> "$SHELL_RC"
  echo "alias c='claude \"go\"'" >> "$SHELL_RC"
  echo -e "  ${GREEN}+${NC} Added CORRHI_VAULT and 'c' alias to ${SHELL_RC}"
fi

echo -e "  ${GREEN}+${NC} Tier 2 complete: Memory + Learning"

if [ "$TIER" -lt 3 ]; then
  echo ""
  echo -e "${BOLD}Done!${NC}"
  echo ""
  echo "Next steps:"
  echo "  1. Open Obsidian → 'Open folder as vault' → ${VAULT_PATH}"
  echo "  2. Restart Terminal (or run: source ${SHELL_RC})"
  echo "  3. Type: c"
  echo "  4. Claude will run /onboard to get to know you."
  echo ""
  exit 0
fi

# ============================================================
# TIER 3: Full Autonomy
# ============================================================

echo ""

# --- Copy autonomous scripts ---
mkdir -p "$CLAUDE_DIR/scripts" "$CLAUDE_DIR/autonomous"

if [ -f "$SCRIPT_DIR/claude-code/scripts/autonomous-work.sh" ]; then
  sed "s|\\\$VAULT_PLACEHOLDER|${VAULT_PATH}|g" \
    "$SCRIPT_DIR/claude-code/scripts/autonomous-work.sh" > "$CLAUDE_DIR/scripts/autonomous-work.sh"
  chmod +x "$CLAUDE_DIR/scripts/autonomous-work.sh"
  echo -e "  ${GREEN}+${NC} Installed autonomous engine"
fi

if [ -f "$SCRIPT_DIR/claude-code/scripts/persistent-remote.sh" ]; then
  sed "s|\\\$VAULT_PLACEHOLDER|${VAULT_PATH}|g; s|\\\$HOME_PLACEHOLDER|${HOME}|g" \
    "$SCRIPT_DIR/claude-code/scripts/persistent-remote.sh" > "$CLAUDE_DIR/scripts/persistent-remote.sh"
  chmod +x "$CLAUDE_DIR/scripts/persistent-remote.sh"
  echo -e "  ${GREEN}+${NC} Installed remote access script"
fi

if [ -f "$SCRIPT_DIR/claude-code/scripts/dispatch-window.sh" ]; then
  cp "$SCRIPT_DIR/claude-code/scripts/dispatch-window.sh" "$CLAUDE_DIR/scripts/dispatch-window.sh"
  chmod +x "$CLAUDE_DIR/scripts/dispatch-window.sh"
  echo -e "  ${GREEN}+${NC} Installed dispatch window script"
fi

# tmux required for Tier 3 remote access (truecolor support)
if ! command -v tmux &>/dev/null; then
  echo -e "  ${YELLOW}!${NC} Installing tmux (required for remote access with truecolor)..."
  brew install tmux 2>/dev/null && echo -e "  ${GREEN}+${NC} tmux installed" || echo -e "  ${YELLOW}!${NC} tmux install failed — run 'brew install tmux' manually"
fi

# tmux config for truecolor
if [ ! -f "$HOME/.tmux.conf" ]; then
  cat > "$HOME/.tmux.conf" << 'TMUXEOF'
# Truecolor support (tmux 3.2+ syntax)
set -g default-terminal "tmux-256color"
set -as terminal-features ",xterm-256color:RGB"
set -as terminal-features ",tmux-256color:RGB"
set -ag terminal-overrides ",*:Tc"

# Allow multiple clients to attach at different sizes
set -g window-size latest

# Pass COLORTERM through to inner sessions
set -ga update-environment "COLORTERM"
set-environment -g COLORTERM truecolor

# Don't auto-rename windows
set -g allow-rename off
TMUXEOF
  echo -e "  ${GREEN}+${NC} Created ~/.tmux.conf (truecolor)"
fi

# --- Install launchd agents ---
LAUNCH_DIR="$HOME/Library/LaunchAgents"
mkdir -p "$LAUNCH_DIR"

for plist in "$SCRIPT_DIR/launchd/"*.plist; do
  [ -f "$plist" ] || continue
  BASENAME=$(basename "$plist")
  sed "s|\\\$HOME|${HOME}|g; s|\\\$VAULT|${VAULT_PATH}|g" \
    "$plist" > "$LAUNCH_DIR/$BASENAME"

  # Load the agent
  launchctl unload "$LAUNCH_DIR/$BASENAME" 2>/dev/null || true
  launchctl load "$LAUNCH_DIR/$BASENAME" 2>/dev/null || true
  echo -e "  ${GREEN}+${NC} Loaded ${BASENAME}"
done

# --- Set power settings (prevent sleep on AC) ---
echo -e "  ${YELLOW}!${NC} Setting 'never sleep on AC power' (requires admin password):"
sudo pmset -c sleep 0 2>/dev/null && echo -e "  ${GREEN}+${NC} Power settings configured" || echo -e "  ${YELLOW}!${NC} Skipped power settings (run 'sudo pmset -c sleep 0' manually)"

echo -e "  ${GREEN}+${NC} Tier 3 complete: Full Autonomy"

echo ""
echo -e "${BOLD}Done!${NC}"
echo ""
echo "Next steps:"
echo "  1. Open Obsidian → 'Open folder as vault' → ${VAULT_PATH}"
echo "  2. Restart Terminal (or run: source ${SHELL_RC})"
echo "  3. Type: c"
echo "  4. Claude will run /onboard to get to know you."
echo "  5. Connect from your phone at claude.ai/code"
echo ""
echo "Autonomous engine polls every 30 minutes, runs burst work when credits are available. Check logs at /tmp/claude-autonomous-stdout.log"
echo ""
