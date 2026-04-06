#!/bin/bash
# validate-yaml.sh — Validate YAML frontmatter after writing vault files
VAULT="${CORRHI_VAULT:-$HOME/Documents/corrhi-vault}"
FILE="$1"

# Only validate files in the vault
case "$FILE" in
  "$VAULT"*) ;;
  *) exit 0 ;;
esac

# Only validate .md files
case "$FILE" in
  *.md) ;;
  *) exit 0 ;;
esac

# Skip _agent/ brain files (different schema)
case "$FILE" in
  "$VAULT/_agent/"*) exit 0 ;;
esac

# Check for YAML frontmatter
if ! head -1 "$FILE" | grep -q "^---$"; then
  echo "WARNING: $FILE missing YAML frontmatter"
fi
