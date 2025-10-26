#!/bin/bash
# Quick LaTeX Environment Setup
# Run this at the start of each session - it's FAST if LaTeX is already installed

TEXLIVE_BIN="/app/.texlive/bin/x86_64-linux"

if [ -f "$TEXLIVE_BIN/xelatex" ]; then
    # Already installed, just add to PATH
    export PATH="$TEXLIVE_BIN:$PATH"
    echo "✅ LaTeX ready (persistent installation)"
    return 0 2>/dev/null || exit 0
else
    # Not installed, run full setup
    echo "⚠️  LaTeX not found. Running one-time installation..."
    bash /app/.setup_latex_persistent.sh
    export PATH="$TEXLIVE_BIN:$PATH"
fi
