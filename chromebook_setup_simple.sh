#!/bin/bash
# Commands to run on your Chromebook to get the LaTeX files

set -e

echo "🚀 Setting up Growlrr LaTeX Project from Emergent"
echo ""

# Create directory
mkdir -p ~/emergent
cd ~/emergent

# Option 1: If repo doesn't exist yet
if [ ! -d "emergent_cookbook" ]; then
    echo "📥 Cloning emergent_cookbook repository..."
    git clone https://github.com/growlrr/emergent_cookbook.git
    cd emergent_cookbook
else
    echo "📥 Updating emergent_cookbook repository..."
    cd emergent_cookbook
    git pull origin main
fi

echo ""
echo "✅ Repository ready!"
echo ""
echo "📂 Repository location: ~/emergent/emergent_cookbook"
echo ""

# Check if LaTeX files exist
if [ -d "docs/latex_project" ]; then
    echo "✅ LaTeX files found!"
    echo ""
    
    # Copy to working directory
    echo "📋 Setting up working directory..."
    rm -rf ~/emergent/latex_project
    cp -r docs/latex_project ~/emergent/latex_project
    
    echo "✅ LaTeX project ready at: ~/emergent/latex_project"
    echo ""
    echo "🎯 To compile:"
    echo "   cd ~/emergent/latex_project"
    echo "   xelatex main.tex"
    echo ""
else
    echo "⚠️  LaTeX files not found in repository yet."
    echo ""
    echo "The files need to be pushed from Emergent first."
    echo "Please use the 'Save to GitHub' feature in Emergent chat."
    echo ""
fi
