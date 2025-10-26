#!/bin/bash
# Quick LaTeX Environment Setup for Chromebook
# Run this at the start of each session - it's FAST if LaTeX is already installed

TEXLIVE_BIN="$HOME/.texlive_growlrr/bin/x86_64-linux"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ -f "$TEXLIVE_BIN/xelatex" ]; then
    # Already installed, just add to PATH
    export PATH="$TEXLIVE_BIN:$PATH"
    echo "✅ LaTeX ready (persistent installation)"
    xelatex --version | head -1
    return 0 2>/dev/null || exit 0
else
    # Not installed, run full setup
    echo "⚠️  LaTeX not found. Running one-time installation..."
    bash "$SCRIPT_DIR/.setup_latex_persistent.sh"
    export PATH="$TEXLIVE_BIN:$PATH"
fi
