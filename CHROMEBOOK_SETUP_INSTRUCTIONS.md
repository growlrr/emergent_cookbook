# Chromebook Setup Instructions for Growlrr LaTeX Project

## 📋 Prerequisites

1. **Enable Linux on Chromebook** (if not already done)
   - Settings → Advanced → Developers → Linux development environment
   - Turn on and wait for setup

2. **Open Terminal** on your Chromebook

## 🎯 Option 1: Interactive Setup (Recommended)

Download and run the interactive setup script:

```bash
# Download the setup script
curl -o setup_latex.sh https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/setup_latex_chromebook.sh

# Make it executable
chmod +x setup_latex.sh

# Run it
./setup_latex.sh
```

The script will:
- Ask for your GitHub repository URL
- Clone/pull from GitHub
- Set up the LaTeX project in `~/emergent/latex_project`
- Create helper scripts for compiling and updating
- Verify your setup

## 🎯 Option 2: Quick Setup (If you know your GitHub URL)

```bash
# Download quick setup
curl -o quick_setup.sh https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/quick_setup.sh

# Edit the file to add your GitHub URL
nano quick_setup.sh
# (Change REPO_URL="YOUR_GITHUB_URL_HERE" to your actual URL)

# Make executable and run
chmod +x quick_setup.sh
./quick_setup.sh
```

## 🎯 Option 3: Manual Setup

```bash
# 1. Create directory
mkdir -p ~/emergent
cd ~/emergent

# 2. Clone your GitHub repository
git clone https://github.com/YOUR_USERNAME/YOUR_REPO.git
cd YOUR_REPO

# 3. Copy LaTeX files
cp -r docs/latex_project ~/emergent/latex_project

# 4. Navigate to project
cd ~/emergent/latex_project

# 5. Compile!
xelatex main.tex
```

## 📦 Install LaTeX (if not installed)

If you don't have LaTeX installed on your Chromebook:

```bash
sudo apt-get update
sudo apt-get install texlive-xetex texlive-fonts-extra texlive-latex-extra texlive-science biber fonts-inter
```

This will take 5-10 minutes to install.

## 🔍 Find Your GitHub Repository URL

### Method 1: From GitHub Website
1. Go to github.com and login
2. Navigate to your repository
3. Click the green "Code" button
4. Copy the HTTPS URL (looks like: `https://github.com/username/repo.git`)

### Method 2: If you have the repo locally
```bash
cd /path/to/your/repo
git remote get-url origin
```

### Method 3: Check GitHub CLI
```bash
gh repo view --web
```

## 📂 Expected Directory Structure

After setup, you'll have:

```
~/emergent/
├── YOUR_REPO/                    # Full GitHub repository
│   └── docs/
│       └── latex_project/        # Original location
└── latex_project/                # Working copy for compilation
    ├── main.tex
    ├── growlrr_style.sty
    ├── growlrr_bibliography.bib
    ├── cookbook/
    ├── README.md
    ├── compile.sh                # Created by setup script
    └── ... (all other files)
```

## ⚡ Quick Compile Commands

### One-time compile (no bibliography):
```bash
cd ~/emergent/latex_project
xelatex main.tex
```

### Full compile (with bibliography):
```bash
cd ~/emergent/latex_project
xelatex main.tex && biber main && xelatex main.tex && xelatex main.tex
```

### Using the helper script (if setup script was used):
```bash
cd ~/emergent/latex_project
./compile.sh          # Full compile
./compile.sh quick    # Quick compile
```

## 🔄 Update from GitHub

If you used the setup script, there's an update helper:

```bash
~/emergent/update_from_github.sh
```

Or manually:
```bash
cd ~/emergent/YOUR_REPO
git pull
cp -r docs/latex_project ~/emergent/latex_project
```

## 🐛 Troubleshooting

### Issue: "git: command not found"
```bash
sudo apt-get install git
```

### Issue: "xelatex: command not found"
Install LaTeX (see "Install LaTeX" section above)

### Issue: "Permission denied"
Make sure script is executable:
```bash
chmod +x scriptname.sh
```

### Issue: "Font not found"
Install Inter font:
```bash
sudo apt-get install fonts-inter
```

### Issue: GitHub authentication
If using HTTPS, you may need to set up credentials:
```bash
git config --global credential.helper store
```
Then run git pull and enter your credentials once.

For SSH, set up SSH keys:
```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
cat ~/.ssh/id_ed25519.pub
# Copy output and add to GitHub: Settings → SSH and GPG keys
```

## 📖 Documentation

After setup, read these files in `~/emergent/latex_project/`:
- **README.md** - Complete compilation guide
- **COMPILATION_REPORT.md** - List of all fixes applied
- **FIXES_SUMMARY.md** - Quick reference

## ✅ Expected Results

After running `xelatex main.tex`:
- **Output:** main.pdf (98 pages)
- **Errors:** 0 fatal errors
- **Status:** Clean compilation

## 🆘 Need Help?

1. Check `main.log` for detailed error messages:
   ```bash
   cat ~/emergent/latex_project/main.log | tail -50
   ```

2. Verify all files are present:
   ```bash
   cd ~/emergent/latex_project
   ls -la
   ```

3. Check LaTeX installation:
   ```bash
   xelatex --version
   biber --version
   ```

---

**Last Updated:** 2025-10-26  
**Tested On:** Chromebook Linux (Debian)
