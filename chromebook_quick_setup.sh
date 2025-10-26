#!/bin/bash
# Setup script for your Chromebook - Growlrr LaTeX Project

echo "🚀 Setting up LaTeX project from GitHub..."
echo ""

# Navigate to your directory
cd ~
mkdir -p emergent
cd emergent

# Clone the repository and checkout latex branch
if [ ! -d "emergent_cookbook" ]; then
    echo "📥 Cloning repository..."
    git clone -b latex https://github.com/growlrr/emergent_cookbook.git
else
    echo "📥 Updating repository..."
    cd emergent_cookbook
    git checkout latex
    git pull origin latex
    cd ..
fi

# Copy files to working directory
echo "📋 Setting up LaTeX working directory..."
cp -r emergent_cookbook/Emergent ~/emergent/latex_project

cd ~/emergent/latex_project

echo ""
echo "✅ Setup complete!"
echo ""
echo "📍 LaTeX files location: ~/emergent/latex_project"
echo ""
echo "🔍 Files present:"
ls -lh main.tex growlrr_style.sty growlrr_bibliography.bib 2>/dev/null || echo "Checking files..."
echo ""
echo "📊 Total .tex files: $(find . -name '*.tex' | wc -l)"
echo ""
echo "🎯 To compile:"
echo "   cd ~/emergent/latex_project"
echo "   xelatex main.tex"
echo ""
echo "📖 For full compilation with bibliography:"
echo "   xelatex main.tex && biber main && xelatex main.tex && xelatex main.tex"
echo ""
