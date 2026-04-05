#!/bin/bash
# resize-images.sh — Resize large images before Claude reads them
# Prevents token waste on high-res images
FILE="$1"

case "$FILE" in
  *.png|*.jpg|*.jpeg|*.PNG|*.JPG|*.JPEG)
    SIZE=$(stat -f %z "$FILE" 2>/dev/null || stat -c %s "$FILE" 2>/dev/null || echo 0)
    if [ "$SIZE" -gt 2000000 ]; then
      # If sips is available (macOS), resize to max 1500px
      if command -v sips &>/dev/null; then
        sips --resampleHeightWidthMax 1500 "$FILE" 2>/dev/null
      fi
    fi
    ;;
esac
