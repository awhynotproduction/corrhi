#!/bin/bash
# autonomous-work.sh — Credit-window-aligned autonomous task execution
#
# Architecture:
#   1. Guards: lockfile, internet, credits, claude CLI, todos file
#   2. Phase 1: Run recurring tasks (serial, one claude session)
#   3. Phase 2: Run active one-time tasks (parallel, up to 3 workers)
#   4. Results go to _review/ as project-tasks
#
# Polls every 30 minutes via launchd (com.corrhi.claude-autonomous).
# Skips instantly when credits depleted. Runs burst work when the
# 5hr rolling window has capacity. The window is the natural governor:
#   burst → credits deplete → polls skip ~5hrs → credits roll off → burst
#
# Credit pacing:
#   - 5hr window: start burst if <70%, continue between batches up to 90%
#   - Weekly (dynamic): threshold = 60 + 39 * (1 - hours_left/168)
#     Fresh week = 60%. Last day = ~94%. Last 4 hours = ~99%.
#   - Sonnet: block if >85%
#
# Modes (set in agent-todos.md frontmatter):
#   normal — 5hr + dynamic weekly governor
#   vacation — use up to 95%
#   light — minimal autonomous work

VAULT="${CORRHI_VAULT:-$HOME/Documents/corrhi-vault}"
LOCAL="${HOME}/.claude/autonomous"
TODOS="${VAULT}/_agent/agent-todos.md"
LOCKFILE="/tmp/claude-autonomous.lock"
LOG="${LOCAL}/autonomous-log.md"

CLAUDE="$(which claude 2>/dev/null || echo "$HOME/.local/bin/claude")"

MAX_WORKERS=3
WORKER_TIMEOUT=14400  # 4 hours per worker
SCRIPT_TIMEOUT=18000  # 5 hours total safety net

mkdir -p "${LOCAL}"

log() { echo "$(date '+%Y-%m-%d %H:%M:%S') $1" >> "${LOG}"; }

# --- Guard: concurrent execution ---
if [ -f "${LOCKFILE}" ]; then
  LOCK_AGE=$(( $(date +%s) - $(stat -f %m "${LOCKFILE}" 2>/dev/null || stat -c %Y "${LOCKFILE}" 2>/dev/null || echo 0) ))
  if [ "${LOCK_AGE}" -lt 21600 ]; then
    log "SKIP: Lock held, age ${LOCK_AGE}s"
    exit 0
  fi
  rm -f "${LOCKFILE}"
fi
echo $$ > "${LOCKFILE}"
trap 'rm -f "${LOCKFILE}"' EXIT

# --- Guard: internet ---
if ! ping -c 1 -W 3 8.8.8.8 &>/dev/null; then
  log "SKIP: No internet"
  exit 0
fi

# --- Guard: claude CLI exists ---
if [ ! -x "${CLAUDE}" ]; then
  log "SKIP: Claude CLI not found at ${CLAUDE}"
  exit 0
fi

# --- Guard: todos file exists ---
if [ ! -f "${TODOS}" ]; then
  log "SKIP: No agent-todos.md found"
  exit 0
fi

# --- Read mode ---
MODE=$(grep '^mode:' "${TODOS}" 2>/dev/null | head -1 | awk '{print $2}')
MODE=${MODE:-normal}

# --- Credit check (Max plan) ---
# Uses OAuth usage API. Adapt get_usage() to your auth method.
# If you don't have OAuth set up, remove this guard and rely on
# Claude Code's built-in rate limiting.
get_usage() {
  # Example for macOS Keychain (Claude Code Max plan):
  # CRED_JSON=$(security find-generic-password -s "Claude Code-credentials" -w 2>/dev/null)
  # OAUTH_TOKEN=$(echo "${CRED_JSON}" | python3 -c "import sys,json; print(json.load(sys.stdin).get('claudeAiOauth',{}).get('accessToken',''))" 2>/dev/null)
  # curl -s -H "Authorization: Bearer ${OAUTH_TOKEN}" -H "anthropic-beta: oauth-2025-04-20" "https://api.anthropic.com/api/oauth/usage" 2>/dev/null
  echo ""  # No-op by default — uncomment above for Max plan credit pacing
}

should_run() {
  local USAGE_DATA="$1"
  [ -z "${USAGE_DATA}" ] && return 0  # No usage data = no credit guard

  eval $(echo "${USAGE_DATA}" | python3 -c "
import sys, json
from datetime import datetime, timezone
d = json.load(sys.stdin)
sonnet = d.get('seven_day_sonnet') or {}
weekly = d.get('seven_day') or {}
five_hr = d.get('five_hour') or {}
s = int(sonnet.get('utilization', -1)) if isinstance(sonnet, dict) else -1
w = int(weekly.get('utilization', -1)) if isinstance(weekly, dict) else -1
f = int(five_hr.get('utilization', -1)) if isinstance(five_hr, dict) else -1
w_hrs = -1
wr = weekly.get('resets_at', '')
if wr:
    try: w_hrs = max(0, int((datetime.fromisoformat(wr) - datetime.now(timezone.utc)).total_seconds() / 3600))
    except: pass
# Dynamic weekly threshold: pace usage across the week.
# Fresh week (168h left) = 60%. End of week (0h left) = 99%.
if w_hrs >= 0:
    w_thresh = int(min(99, max(60, 60 + 39 * (1 - w_hrs / 168))))
else:
    w_thresh = 80
print(f'S_UTIL={s}; W_UTIL={w}; F_UTIL={f}; W_HRS={w_hrs}; W_THRESH={w_thresh}')
" 2>/dev/null)

  log "CREDIT: sonnet=${S_UTIL}% weekly=${W_UTIL}% 5hr=${F_UTIL}% weekly_reset=${W_HRS}h weekly_thresh=${W_THRESH}% mode=${MODE}"

  case "${MODE}" in
    vacation)
      [ "${S_UTIL}" -gt 95 ] 2>/dev/null && { log "SKIP: vacation but sonnet >95%"; return 1; }
      [ "${W_UTIL}" -gt 95 ] 2>/dev/null && { log "SKIP: vacation but weekly >95%"; return 1; }
      return 0 ;;
    light)
      [ "${S_UTIL}" -gt 20 ] 2>/dev/null && { log "SKIP: light mode"; return 1; }
      return 0 ;;
  esac

  # 5hr window is the primary governor
  [ "${F_UTIL}" -gt 70 ] 2>/dev/null && { log "SKIP: 5hr at ${F_UTIL}%"; return 1; }
  # Weekly: dynamic threshold based on time remaining
  [ "${W_UTIL}" -gt "${W_THRESH}" ] 2>/dev/null && { log "SKIP: weekly ${W_UTIL}% > thresh ${W_THRESH}% (${W_HRS}h to reset)"; return 1; }
  # Sonnet: only block if nearly maxed
  [ "${S_UTIL}" -gt 85 ] 2>/dev/null && { log "SKIP: sonnet at ${S_UTIL}%"; return 1; }

  return 0
}

USAGE_DATA=$(get_usage)
if [ -n "${USAGE_DATA}" ]; then
  should_run "${USAGE_DATA}" || exit 0
fi

log "Starting autonomous session (mode=${MODE})"

# --- Build task prompt from agent-todos.md ---
TASK_PROMPT="You are running in autonomous mode. Today: $(date '+%Y-%m-%d %H:%M %Z'). No human present.

Read _agent/agent-todos.md and execute any tasks that are due:
- Recurring tasks: check schedule (every:) and last run date (last:)
- Active tasks: execute in order
- Reminders: skip (these are for interactive sessions)

Write results to _review/ as project-tasks with YAML frontmatter.
Update agent-todos.md with completion timestamps.
Do NOT modify project files directly — propose changes via _review/.
Be efficient — use the model specified by each task."

# --- Run ---
cd "${HOME}"
timeout ${SCRIPT_TIMEOUT} "${CLAUDE}" -p "${TASK_PROMPT}" \
  --permission-mode bypassPermissions \
  --model opus \
  2>> "${LOG}" || log "Session ended (timeout or error)"

log "Autonomous session complete"
