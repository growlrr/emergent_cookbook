#!/bin/bash
# Quick setup - Edit REPO_URL below with your GitHub repository

# ==========================================
# CONFIGURATION - EDIT THIS!
# ==========================================
REPO_URL="YOUR_GITHUB_URL_HERE"
# Example: REPO_URL="https://github.com/yourusername/your-repo.git"

# ==========================================
# Setup starts here
# ==========================================

set -e

echo "🚀 Setting up Growlrr LaTeX Project..."
echo ""

# Check if REPO_URL is set
if [ "$REPO_URL" == "YOUR_GITHUB_URL_HERE" ]; then
    echo "❌ Error: Please edit this script and set your REPO_URL"
    echo ""
    echo "Open this file and replace:"
    echo '  REPO_URL="YOUR_GITHUB_URL_HERE"'
    echo "with:"
    echo '  REPO_URL="https://github.com/yourusername/your-repo.git"'
    exit 1
fi

# Create directory
mkdir -p ~/emergent
cd ~/emergent

# Clone or update
REPO_NAME=$(basename "$REPO_URL" .git)
if [ -d "$REPO_NAME/.git" ]; then
    echo "📥 Updating existing repository..."
    cd "$REPO_NAME"
    git pull
else
    echo "📥 Cloning repository..."
    git clone "$REPO_URL"
    cd "$REPO_NAME"
fi

# Copy LaTeX files
echo "📋 Setting up LaTeX project..."
rm -rf ~/emergent/latex_project
cp -r docs/latex_project ~/emergent/latex_project

# Done
echo ""
echo "✅ Setup complete!"
echo ""
echo "📍 Location: ~/emergent/latex_project"
echo ""
echo "To compile:"
echo "  cd ~/emergent/latex_project"
echo "  xelatex main.tex"
echo ""
