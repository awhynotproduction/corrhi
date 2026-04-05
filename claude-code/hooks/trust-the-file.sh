#!/bin/bash
# trust-the-file.sh — Remind Claude to verify against disk before responding
# Triggered on every user prompt submission

cat << 'EOF'
Before responding: search relevant files, then verify that what you're about to say matches what the files actually contain. If a file shows X but your instinct says Y, trust the file. Never narrate a diagnosis, status, or fact without confirming it against current file contents.
EOF
