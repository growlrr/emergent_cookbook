#!/bin/bash
# Setup script for Growlrr LaTeX Project from GitHub
# Run this script from your Chromebook's home directory

set -e  # Exit on any error

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}================================================${NC}"
echo -e "${BLUE}  Growlrr LaTeX Project Setup Script${NC}"
echo -e "${BLUE}================================================${NC}"
echo ""

# ==========================================
# STEP 1: Get GitHub repository URL
# ==========================================
echo -e "${YELLOW}Step 1: GitHub Repository${NC}"
echo ""
echo "Please enter your GitHub repository URL."
echo "Examples:"
echo "  - HTTPS: https://github.com/yourusername/your-repo.git"
echo "  - SSH:   git@github.com:yourusername/your-repo.git"
echo ""
read -p "GitHub Repository URL: " REPO_URL

if [ -z "$REPO_URL" ]; then
    echo -e "${RED}Error: Repository URL cannot be empty${NC}"
    exit 1
fi

# ==========================================
# STEP 2: Create directory structure
# ==========================================
echo ""
echo -e "${YELLOW}Step 2: Creating directory structure${NC}"

# Get home directory
HOME_DIR="$HOME"
EMERGENT_DIR="$HOME_DIR/emergent"
LATEX_DIR="$EMERGENT_DIR/latex_project"

echo "Creating directory: $EMERGENT_DIR"
mkdir -p "$EMERGENT_DIR"
cd "$EMERGENT_DIR"

# ==========================================
# STEP 3: Clone or pull repository
# ==========================================
echo ""
echo -e "${YELLOW}Step 3: Fetching from GitHub${NC}"

REPO_NAME=$(basename "$REPO_URL" .git)
CLONE_DIR="$EMERGENT_DIR/$REPO_NAME"

if [ -d "$CLONE_DIR/.git" ]; then
    echo "Repository already exists. Pulling latest changes..."
    cd "$CLONE_DIR"
    git pull
else
    echo "Cloning repository..."
    cd "$EMERGENT_DIR"
    git clone "$REPO_URL"
    cd "$CLONE_DIR"
fi

# ==========================================
# STEP 4: Copy LaTeX files to working directory
# ==========================================
echo ""
echo -e "${YELLOW}Step 4: Setting up LaTeX project${NC}"

if [ ! -d "$CLONE_DIR/docs/latex_project" ]; then
    echo -e "${RED}Error: LaTeX project not found in docs/latex_project${NC}"
    echo "Looking for alternative locations..."
    
    # Try to find main.tex
    MAIN_TEX=$(find "$CLONE_DIR" -name "main.tex" -type f | head -1)
    if [ -n "$MAIN_TEX" ]; then
        LATEX_SOURCE=$(dirname "$MAIN_TEX")
        echo "Found LaTeX files in: $LATEX_SOURCE"
    else
        echo -e "${RED}Error: Could not find main.tex in repository${NC}"
        exit 1
    fi
else
    LATEX_SOURCE="$CLONE_DIR/docs/latex_project"
fi

echo "Copying LaTeX files to: $LATEX_DIR"
rm -rf "$LATEX_DIR"
cp -r "$LATEX_SOURCE" "$LATEX_DIR"

# ==========================================
# STEP 5: Verify setup
# ==========================================
echo ""
echo -e "${YELLOW}Step 5: Verifying setup${NC}"

cd "$LATEX_DIR"

if [ ! -f "main.tex" ]; then
    echo -e "${RED}Error: main.tex not found!${NC}"
    exit 1
fi

echo -e "${GREEN}✓${NC} main.tex found"

if [ ! -f "growlrr_style.sty" ]; then
    echo -e "${YELLOW}⚠${NC} growlrr_style.sty not found (may cause compilation issues)"
else
    echo -e "${GREEN}✓${NC} growlrr_style.sty found"
fi

if [ ! -f "growlrr_bibliography.bib" ]; then
    echo -e "${YELLOW}⚠${NC} growlrr_bibliography.bib not found"
else
    echo -e "${GREEN}✓${NC} growlrr_bibliography.bib found"
fi

# Count .tex files
TEX_COUNT=$(find . -name "*.tex" -type f | wc -l)
echo -e "${GREEN}✓${NC} Found $TEX_COUNT .tex files"

# ==========================================
# STEP 6: Check LaTeX installation
# ==========================================
echo ""
echo -e "${YELLOW}Step 6: Checking LaTeX installation${NC}"

if command -v xelatex &> /dev/null; then
    echo -e "${GREEN}✓${NC} xelatex is installed"
    XELATEX_VERSION=$(xelatex --version | head -1)
    echo "  Version: $XELATEX_VERSION"
else
    echo -e "${RED}✗${NC} xelatex not found"
    echo ""
    echo "To install LaTeX on Chromebook (Linux):"
    echo "  sudo apt-get update"
    echo "  sudo apt-get install texlive-xetex texlive-fonts-extra texlive-latex-extra texlive-science biber fonts-inter"
fi

if command -v biber &> /dev/null; then
    echo -e "${GREEN}✓${NC} biber is installed"
else
    echo -e "${YELLOW}⚠${NC} biber not found (needed for bibliography)"
fi

# ==========================================
# COMPLETION
# ==========================================
echo ""
echo -e "${BLUE}================================================${NC}"
echo -e "${GREEN}✓ Setup Complete!${NC}"
echo -e "${BLUE}================================================${NC}"
echo ""
echo "LaTeX project location:"
echo "  ${GREEN}$LATEX_DIR${NC}"
echo ""
echo "To compile your document:"
echo "  ${BLUE}cd $LATEX_DIR${NC}"
echo "  ${BLUE}xelatex main.tex${NC}"
echo ""
echo "For full compilation with bibliography:"
echo "  ${BLUE}xelatex main.tex && biber main && xelatex main.tex && xelatex main.tex${NC}"
echo ""
echo "To view documentation:"
echo "  ${BLUE}cat README.md${NC}"
echo ""

# Create a convenience script
COMPILE_SCRIPT="$LATEX_DIR/compile.sh"
cat > "$COMPILE_SCRIPT" << 'COMPILE_EOF'
#!/bin/bash
# Quick compile script for Growlrr LaTeX project

echo "Compiling LaTeX document..."
echo ""

if [ "$1" == "quick" ]; then
    echo "Running quick compile (no bibliography)..."
    xelatex -interaction=nonstopmode main.tex
else
    echo "Running full compile (with bibliography)..."
    xelatex -interaction=nonstopmode main.tex
    biber main
    xelatex -interaction=nonstopmode main.tex
    xelatex -interaction=nonstopmode main.tex
fi

if [ -f "main.pdf" ]; then
    PAGES=$(pdfinfo main.pdf 2>/dev/null | grep "Pages:" | awk '{print $2}')
    SIZE=$(ls -lh main.pdf | awk '{print $5}')
    echo ""
    echo "✓ Compilation successful!"
    echo "  Output: main.pdf"
    [ -n "$PAGES" ] && echo "  Pages: $PAGES"
    echo "  Size: $SIZE"
else
    echo ""
    echo "✗ Compilation failed. Check the log file:"
    echo "  cat main.log"
fi
COMPILE_EOF

chmod +x "$COMPILE_SCRIPT"
echo "Compile script created: ${GREEN}$COMPILE_SCRIPT${NC}"
echo "  Usage: ${BLUE}./compile.sh${NC}        (full compile)"
echo "         ${BLUE}./compile.sh quick${NC}   (quick compile)"
echo ""

# Create update script
UPDATE_SCRIPT="$EMERGENT_DIR/update_from_github.sh"
cat > "$UPDATE_SCRIPT" << UPDATE_EOF
#!/bin/bash
# Update LaTeX project from GitHub

cd "$CLONE_DIR"
echo "Pulling latest changes from GitHub..."
git pull

echo "Updating LaTeX files..."
rm -rf "$LATEX_DIR"
cp -r "$LATEX_SOURCE" "$LATEX_DIR"

echo "✓ Update complete!"
echo "LaTeX files updated in: $LATEX_DIR"
UPDATE_EOF

chmod +x "$UPDATE_SCRIPT"
echo "Update script created: ${GREEN}$UPDATE_SCRIPT${NC}"
echo "  Run this anytime to pull latest changes from GitHub"
echo ""
echo -e "${GREEN}Happy LaTeX compiling! 📄✨${NC}"
