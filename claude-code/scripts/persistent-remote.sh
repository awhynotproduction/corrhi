#!/bin/bash
# persistent-remote.sh — Keep an interactive Claude session alive with remote access
# Runs via launchd with KeepAlive. Uses tmux for PTY (no Terminal.app dependency, truecolor).
#
# Architecture: Two launchd agents work together:
#   1. This script (com.corrhi.claude-remote) — headless tmux session running claude
#   2. dispatch-window.sh (com.corrhi.dispatch-window) — Terminal.app viewport
#
# If Terminal.app crashes, the tmux session (and mobile access) survives.
#
# Management:
#   Attach:         tmux attach -t corrhi-dispatch   (or alias: dispatch)
#   Force restart:  tmux kill-session -t corrhi-dispatch  (launchd restarts in ~30s)
#   Check status:   tmux has-session -t corrhi-dispatch
#   Logs:           cat /tmp/claude-remote.log

export HOME="${HOME:-/Users/$(whoami)}"
export PATH="$HOME/.local/bin:/opt/homebrew/bin:/usr/local/bin:/usr/sbin:/usr/bin:/bin"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export COLORTERM="truecolor"

TMUX_BIN="$(command -v tmux)"
SESSION_NAME="corrhi-dispatch"
LOG="/tmp/claude-remote.log"
log() { echo "$(date '+%Y-%m-%d %H:%M:%S') $1" >> "$LOG"; }

# Rotate log if over 100KB
if [ -f "$LOG" ] && [ "$(stat -f%z "$LOG" 2>/dev/null || echo 0)" -gt 102400 ]; then
    mv "$LOG" "${LOG}.old"
fi

# Wait for network (up to 2 min, then exit and let launchd retry)
attempts=0
while ! networksetup -getinfo Wi-Fi 2>/dev/null | grep -q "^IP address: [0-9]"; do
    attempts=$((attempts + 1))
    if [ $attempts -ge 12 ]; then
        log "No WiFi after 2 min — exiting for launchd retry"
        exit 1
    fi
    sleep 10
done

# Clean up stale tmux session (if one exists from a previous run)
$TMUX_BIN kill-session -t "$SESSION_NAME" 2>/dev/null || true
sleep 2

log "Network connected — starting corrhi dispatch via tmux"

# TMUX= unsets the TMUX env var for claude — works around a Bun runtime bug where
# getColorDepth() sees $TMUX and forces 256-color mode, ignoring COLORTERM=truecolor
$TMUX_BIN new-session -d -s "$SESSION_NAME" -x 200 -y 50 \
    "TMUX= COLORTERM=truecolor $HOME/.local/bin/claude --remote-control --name 'corrhi' --permission-mode bypassPermissions"

# Wait for the tmux session to end (poll since we can't exec into tmux server)
while $TMUX_BIN has-session -t "$SESSION_NAME" 2>/dev/null; do
    sleep 5
done

log "Dispatch session ended — exiting for launchd restart"
exit 0
