#!/bin/bash
# session-start.sh — Vault status check on session start
VAULT="${CORRHI_VAULT:-$HOME/Documents/corrhi-vault}"

REVIEW_COUNT=0
if [ -d "$VAULT/_review" ]; then
  REVIEW_COUNT=$(find "$VAULT/_review" -name "*.md" -maxdepth 1 2>/dev/null | wc -l | tr -d ' ')
fi

CAPTURE_COUNT=0
if [ -d "$VAULT/capture" ]; then
  CAPTURE_COUNT=$(find "$VAULT/capture" -name "*.md" -maxdepth 1 -not -name "*.gitkeep" 2>/dev/null | wc -l | tr -d ' ')
fi

cat << EOF
Vault status: $REVIEW_COUNT items in _review/. $CAPTURE_COUNT unprocessed captures.
Read _claude/goals.md for session continuity. Run /open-session.
EOF
