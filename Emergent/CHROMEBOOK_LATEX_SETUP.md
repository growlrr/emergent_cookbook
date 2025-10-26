# Persistent LaTeX Setup for Your Chromebook

## 🎯 What This Does

Installs LaTeX to `~/.texlive_growlrr` on your Chromebook so you only install it ONCE, then it's always available.

---

## 🚀 First Time Setup (5 minutes)

```bash
cd ~/emergent/emergent_cookbook/Emergent
source .activate_latex.sh
```

This will:
- Check if LaTeX is already installed
- If not, install it to `~/.texlive_growlrr` (~300MB)
- Takes ~5 minutes first time only
- Then always available instantly!

---

## 📖 Daily Usage (Instant)

Every time you want to work on LaTeX:

```bash
cd ~/emergent/emergent_cookbook/Emergent
source .activate_latex.sh

# Now compile anything
xelatex main.tex
xelatex test_tables.tex
biber main
```

The second and all future times: **Activates in <1 second!**

---

## 📋 Complete Workflow

### Pull Latest Changes
```bash
cd ~/emergent/emergent_cookbook
git pull origin latex
```

### Activate LaTeX
```bash
cd Emergent
source .activate_latex.sh
```

### Compile Test PDF (25 pages)
```bash
xelatex test_tables.tex
```

### View PDF
```bash
xdg-open test_tables.pdf
# Or double-click in file browser
```

### Compile Full Document (111 pages)
```bash
xelatex main.tex
biber main
xelatex main.tex
xelatex main.tex
xdg-open main.pdf
```

---

## 💰 Cost Savings

**System LaTeX (your current setup):**
- Already installed on Chromebook
- Uses system resources
- No reinstall needed

**Persistent LaTeX (this setup):**
- Installs to your home directory
- Survives Chromebook updates/restarts better
- Separate from system (cleaner)
- One-time 5 min install, then instant forever

**Both work fine!** This is just an alternative if you want a dedicated LaTeX install.

---

## 🔧 Troubleshooting

### If LaTeX not found after activation:
```bash
# Check installation
ls -la ~/.texlive_growlrr/bin/x86_64-linux/xelatex

# Manually add to PATH
export PATH="$HOME/.texlive_growlrr/bin/x86_64-linux:$PATH"
xelatex --version
```

### To reinstall:
```bash
rm -rf ~/.texlive_growlrr
source .activate_latex.sh  # Will reinstall
```

### To use system LaTeX instead:
```bash
# Just skip the 'source .activate_latex.sh' step
# Your system xelatex will be used automatically
```

---

## 📁 What Gets Installed

**Location:** `~/.texlive_growlrr/`  
**Size:** ~300MB  
**Packages:**
- XeLaTeX engine
- Essential packages (fontspec, unicode-math, geometry, etc.)
- Bibliography tools (biblatex, biber)
- Scientific packages (siunitx, amssymb)
- Tables & graphics (booktabs, longtable, tikz, adjustbox)
- Inter font family

---

**You can use either system LaTeX or persistent LaTeX - both will work!**
