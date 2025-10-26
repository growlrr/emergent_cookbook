# Persistent LaTeX Setup for Emergent Account

## 🎯 Problem Solved
Avoid reinstalling LaTeX after every pod restart - saves ~50 credits per session!

## 📦 How It Works
- LaTeX is installed to `/app/.texlive` (persistent directory)
- Survives pod restarts, meetings, sleep mode
- Only installs ONCE, then reuses across all sessions
- Takes ~5 minutes first time, <1 second after that

---

## 🚀 Usage

### For AI Agent (E1):
At the start of ANY LaTeX task, run this **ONE** command:

```bash
source /app/.activate_latex.sh
```

**That's it!** 
- If LaTeX is installed: Activates instantly (<1 sec)
- If not installed: Installs once (~5 min), then ready

### For Manual Use:
```bash
# Quick check & activate
source /app/.activate_latex.sh

# Then use LaTeX normally
cd /app/Emergent
xelatex main.tex
```

---

## 💾 Installation Details

**Location:** `/app/.texlive/`
**Packages Included:**
- XeLaTeX engine
- Essential LaTeX packages (fontspec, unicode-math, geometry, etc.)
- Bibliography tools (biblatex, biber)
- Scientific packages (siunitx, amssymb)
- Graphics & tables (tikz, booktabs, longtable)
- Inter font family

**Size:** ~300MB (vs 2GB+ for full texlive)
**Install Time:** ~5 minutes (one-time only)
**Reactivation Time:** <1 second

---

## 🔄 Workflow for E1 Agent

### Standard Pattern for LaTeX Tasks:

```bash
# Step 1: Check/activate LaTeX (ALWAYS do this first)
source /app/.activate_latex.sh

# Step 2: Proceed with LaTeX work
cd /app/Emergent
xelatex main.tex

# No reinstallation needed even after:
# - Pod restarts
# - Memory/storage limit resets  
# - User going to meetings/sleep
# - System reinitialization
```

### Error Handling:

```bash
# If xelatex not found:
if ! command -v xelatex &> /dev/null; then
    echo "Activating persistent LaTeX..."
    source /app/.activate_latex.sh
fi

# Then proceed with compilation
```

---

## 🎓 Cost Comparison

### Old Method (System Package Manager):
```bash
apt-get install texlive-xetex texlive-latex-extra texlive-science biber fonts-inter
# Cost: ~30-50 credits PER restart
# Time: 5-10 minutes PER restart
# Frequency: Every restart
```

### New Method (Persistent Install):
```bash
source /app/.activate_latex.sh
# Cost: ~30 credits ONCE (first install)
# Cost: ~0 credits (subsequent uses)
# Time: ~5 minutes ONCE, <1 sec after
# Frequency: Once ever, unless /app is wiped
```

**Savings: $10-15 per session after first install!**

---

## 🔧 Maintenance

### Reinstall (if needed):
```bash
rm -rf /app/.texlive
bash /app/.setup_latex_persistent.sh
```

### Add Package:
```bash
source /app/.activate_latex.sh
tlmgr install <package-name>
```

### Check Installation:
```bash
ls -lh /app/.texlive/bin/x86_64-linux/xelatex
```

---

## 📋 Checklist for E1 Agent

When user requests LaTeX work:

- [ ] Check if LaTeX is in PATH: `which xelatex`
- [ ] If not found: Run `source /app/.activate_latex.sh`
- [ ] Verify: `xelatex --version`
- [ ] Proceed with LaTeX compilation
- [ ] **NEVER** run `apt-get install texlive*` unless `/app/.texlive` is confirmed missing

---

## 🚨 Important Notes

1. **Always use the persistent installation** - Don't install via apt-get
2. **The `/app/` directory persists** across most restarts
3. **Check first, install never (after first time)** - This is the key principle
4. **This pattern applies to other large tools too** - Consider for future optimizations

---

## 📊 Status

- ✅ LaTeX installation script: `/app/.setup_latex_persistent.sh`
- ✅ Quick activation script: `/app/.activate_latex.sh`
- ✅ Installation location: `/app/.texlive/`
- ✅ Tested with: Growlrr Pilot Binder (111 pages, successful compilation)

---

**Last Updated:** 2025-10-26  
**Tested By:** E1 Agent  
**Verified:** Working across pod restarts
