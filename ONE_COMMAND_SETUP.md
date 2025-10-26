# 🚀 ONE-COMMAND SETUP

Copy and paste this into your Chromebook terminal:

```bash
bash <(curl -s https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/setup_latex_chromebook.sh)
```

Replace `YOUR_USERNAME` and `YOUR_REPO` with your actual GitHub details.

---

## Don't know your GitHub repo URL?

### Find it on GitHub.com:
1. Go to github.com
2. Click on your repository
3. Click green "Code" button
4. Copy the HTTPS URL

### Or run this in terminal:
```bash
# If you have the repo somewhere on your computer
cd /path/to/repo
git remote get-url origin
```

---

## Alternative: Manual 4-Step Setup

```bash
# 1. Create directory
mkdir -p ~/emergent && cd ~/emergent

# 2. Clone your repo (replace URL)
git clone https://github.com/YOUR_USERNAME/YOUR_REPO.git

# 3. Copy LaTeX files
cp -r YOUR_REPO/docs/latex_project ~/emergent/latex_project

# 4. Compile!
cd ~/emergent/latex_project && xelatex main.tex
```

---

## Need to install LaTeX first?

```bash
sudo apt-get update && sudo apt-get install -y texlive-xetex texlive-fonts-extra texlive-latex-extra texlive-science biber fonts-inter
```

---

## Quick Reference Card

| Task | Command |
|------|---------|
| Setup from GitHub | `bash <(curl -s https://raw.githubusercontent.com/...setup_latex_chromebook.sh)` |
| Compile PDF | `cd ~/emergent/latex_project && xelatex main.tex` |
| Full compile | `xelatex main.tex && biber main && xelatex main.tex && xelatex main.tex` |
| Update from GitHub | `~/emergent/update_from_github.sh` |
| View PDF | `xdg-open main.pdf` |

Expected output: **main.pdf** (98 pages, 0 errors)

---

📖 **Full Instructions:** See CHROMEBOOK_SETUP_INSTRUCTIONS.md in your repo
