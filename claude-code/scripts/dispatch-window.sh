#!/bin/bash
# dispatch-window.sh — Auto-open a Terminal window attached to the dispatch session
# Runs via launchd (com.corrhi.dispatch-window). If the window closes, launchd restarts.
#
# The main session lives in tmux (managed by com.corrhi.claude-remote).
# This script just keeps a visible Terminal.app window attached.
# Mobile connects via claude.ai/code (--remote-control). Both see the same session.

export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/sbin:/usr/bin:/bin"
TMUX_BIN="$(command -v tmux)"
SESSION_NAME="corrhi-dispatch"
LOG="/tmp/dispatch-window.log"
log() { echo "$(date '+%Y-%m-%d %H:%M:%S') $1" >> "$LOG"; }

# Wait for the tmux session to exist (up to 2 min)
attempts=0
while ! $TMUX_BIN has-session -t "$SESSION_NAME" 2>/dev/null; do
    attempts=$((attempts + 1))
    if [ $attempts -ge 24 ]; then
        log "No $SESSION_NAME session after 2 min — exiting for launchd retry"
        exit 1
    fi
    sleep 5
done

log "$SESSION_NAME session found — opening Terminal window"

# Open Terminal.app attached to the tmux session
osascript <<APPLESCRIPT
tell application "Terminal"
    activate
    do script "$TMUX_BIN attach -t $SESSION_NAME"
end tell
APPLESCRIPT

# Monitor: stay alive while a tmux client is attached
sleep 5
while $TMUX_BIN list-clients -t "$SESSION_NAME" 2>/dev/null | grep -q .; do
    sleep 10
done

log "Terminal attachment lost — exiting for launchd restart"
exit 0
