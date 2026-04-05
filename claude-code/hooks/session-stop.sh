#!/bin/bash
# session-stop.sh — Safety check before session ends
VAULT="${CORRHI_VAULT:-$HOME/Documents/corrhi-vault}"

WARNINGS=""

# Check for uncommitted vault changes
if [ -d "$VAULT/.git" ]; then
  cd "$VAULT"
  UNCOMMITTED=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')
  if [ "$UNCOMMITTED" -gt 0 ]; then
    WARNINGS="${WARNINGS}WARNING: $UNCOMMITTED uncommitted vault changes. "
  fi

  UNPUSHED=$(git log --oneline @{u}..HEAD 2>/dev/null | wc -l | tr -d ' ')
  if [ "$UNPUSHED" -gt 0 ]; then
    WARNINGS="${WARNINGS}WARNING: $UNPUSHED unpushed commits. "
  fi
fi

if [ -n "$WARNINGS" ]; then
  echo "$WARNINGS"
fi
