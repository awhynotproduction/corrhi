#!/bin/bash
# auto-commit.sh — Auto-commit vault changes after writes/edits
VAULT="${CORRHI_VAULT:-$HOME/Documents/corrhi-vault}"
FILE="$1"

# Only auto-commit files in the vault
case "$FILE" in
  "$VAULT"*) ;;
  *) exit 0 ;;
esac

# Skip if not a git repo
[ -d "$VAULT/.git" ] || exit 0

cd "$VAULT"

# Get relative path for commit message
REL_PATH="${FILE#$VAULT/}"

git add "$REL_PATH" 2>/dev/null
git commit -m "auto: update $REL_PATH" --no-gpg-sign 2>/dev/null || true
