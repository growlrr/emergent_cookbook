#!/bin/bash
# Persistent LaTeX Setup for Chromebook
# Installs LaTeX to ~/.texlive_growlrr which persists across restarts

TEXLIVE_DIR="$HOME/.texlive_growlrr"
TEXLIVE_BIN="$TEXLIVE_DIR/bin/x86_64-linux"
INSTALLER_URL="https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz"

echo "🔍 Checking for existing LaTeX installation..."

# Check if already installed
if [ -f "$TEXLIVE_BIN/xelatex" ]; then
    echo "✅ LaTeX already installed at $TEXLIVE_DIR"
    export PATH="$TEXLIVE_BIN:$PATH"
    xelatex --version | head -1
    echo ""
    echo "📍 To use in your session:"
    echo "   export PATH=\"$TEXLIVE_BIN:\$PATH\""
    exit 0
fi

echo "📦 LaTeX not found. Installing to persistent location..."
echo "⏱️  This will take ~5 minutes but only needs to happen ONCE"
echo ""

# Create directory
mkdir -p "$TEXLIVE_DIR"
cd /tmp

# Download installer
echo "1/4 Downloading TeX Live installer..."
wget -q "$INSTALLER_URL" -O install-tl.tar.gz
tar -xzf install-tl.tar.gz
cd install-tl-*

# Create minimal install profile
cat > texlive.profile << EOF
selected_scheme scheme-basic
TEXDIR $TEXLIVE_DIR
TEXMFLOCAL $TEXLIVE_DIR/texmf-local
TEXMFSYSVAR $TEXLIVE_DIR/texmf-var
TEXMFSYSCONFIG $TEXLIVE_DIR/texmf-config
TEXMFVAR $HOME/.texlive/texmf-var
TEXMFCONFIG $HOME/.texlive/texmf-config
TEXMFHOME $HOME/texmf
binary_x86_64-linux 1
instopt_adjustpath 0
instopt_adjustrepo 1
instopt_letter 0
instopt_portable 1
instopt_write18_restricted 1
tlpdbopt_autobackup 0
tlpdbopt_backupdir tlpkg/backups
tlpdbopt_create_formats 1
tlpdbopt_desktop_integration 0
tlpdbopt_file_assocs 0
tlpdbopt_generate_updmap 0
tlpdbopt_install_docfiles 0
tlpdbopt_install_srcfiles 0
tlpdbopt_post_code 1
EOF

# Install basic TeX Live
echo "2/4 Installing basic TeX Live (this takes ~3 min)..."
./install-tl --profile=texlive.profile --no-interaction > /tmp/texlive_install.log 2>&1

# Add to PATH
export PATH="$TEXLIVE_BIN:$PATH"

# Install only required packages
echo "3/4 Installing required packages..."
tlmgr install \
    xetex \
    fontspec \
    unicode-math \
    geometry \
    xcolor \
    graphicx \
    booktabs \
    longtable \
    array \
    adjustbox \
    caption \
    enumitem \
    setspace \
    titlesec \
    fancyhdr \
    hyperref \
    biblatex \
    biber \
    siunitx \
    amssymb \
    amsmath \
    pgf \
    > /tmp/texlive_packages.log 2>&1

# Install fonts
echo "4/4 Installing fonts..."
sudo apt-get update > /dev/null 2>&1
sudo apt-get install -y --no-install-recommends fonts-inter > /dev/null 2>&1

# Cleanup
cd /tmp
rm -rf install-tl* texlive*.log

echo ""
echo "✅ LaTeX installed successfully!"
echo ""
echo "📍 Installation location: $TEXLIVE_DIR"
echo "🎯 To use in your session, run:"
echo "   export PATH=\"$TEXLIVE_BIN:\$PATH\""
echo ""
echo "💾 This installation persists across restarts!"
echo ""

# Test
xelatex --version | head -1
