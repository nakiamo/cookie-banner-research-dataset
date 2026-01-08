# Next Steps: GitHub Repository Setup

**Repository Name:** `familiarity-research-dataset`  
**Status:** ✅ Ready for GitHub

---

## Current Status

✅ **All files prepared:**
- README.md (updated with your changes)
- .gitignore (configured)
- 01_data/ (dataset)
- 02_experimental_materials/ (JavaScript + website prototypes)
- 03_analysis_code/ (R scripts + documentation)
- 39 files total ready for commit

---

## Step-by-Step Instructions

### 1. Navigate to Repository Folder

```bash
cd Cursor_Files/exports/github_data_deposit
```

### 2. Initialize Git Repository

```bash
git init
```

### 3. Add All Files

```bash
git add .
```

### 4. Verify What Will Be Committed

```bash
git status
```

This will show you all files that will be committed. Verify that:
- ✅ README.md is included
- ✅ .gitignore is included
- ✅ All data, scripts, and materials are included
- ❌ No .DS_Store or other unwanted files

### 5. Create Initial Commit

```bash
git commit -m "Initial commit: Familiarity and Privacy Research Dataset

- Complete dataset (N=594)
- Experimental materials (4 website prototypes + JavaScript)
- Analysis code (R scripts for all hypotheses H1-H7)
- Documentation (README, code documentation)"
```

### 6. Create GitHub Repository

1. Go to https://github.com/new
2. Repository name: `familiarity-research-dataset`
3. Description: "Dataset, experimental materials, and analysis code for study on website familiarity and cookie banner interface effects on privacy consent decisions"
4. Visibility: Choose Public or Private
5. **DO NOT** initialize with README, .gitignore, or license (we already have these)
6. Click "Create repository"

### 7. Connect Local Repository to GitHub

After creating the repository on GitHub, you'll see instructions. Use these commands:

```bash
git remote add origin https://github.com/[YOUR_USERNAME]/familiarity-research-dataset.git
git branch -M main
git push -u origin main
```

**Note:** Replace `[YOUR_USERNAME]` with your actual GitHub username.

---

## Verification Checklist

Before pushing, verify:

- [ ] All files are committed (`git status` shows "nothing to commit")
- [ ] README.md is accurate and complete
- [ ] .gitignore is working (no .DS_Store or .Rhistory files)
- [ ] All R scripts are generic (no personal paths)
- [ ] Dataset is anonymized
- [ ] Repository structure matches README.md

---

## After Pushing

### Optional: Add Repository Topics

Go to your repository on GitHub → Settings → Topics, and add:
- `privacy`
- `cookie-consent`
- `experimental-design`
- `r`
- `javascript`
- `research-data`

### Optional: Add License

If you want to add a license:
1. Go to repository → Add file → Create new file
2. Name it `LICENSE`
3. Choose a license (e.g., MIT, CC BY 4.0)
4. Commit

### Optional: Enable GitHub Pages

If you want to host the website prototypes:
1. Go to Settings → Pages
2. Source: Deploy from a branch
3. Branch: main, folder: /02_experimental_materials/website_prototypes/

---

## Troubleshooting

### If you get authentication errors:
- Use GitHub CLI: `gh auth login`
- Or use SSH: `git remote set-url origin git@github.com:[USERNAME]/familiarity-research-dataset.git`

### If files are too large:
- GitHub has a 100MB file limit
- Check file sizes: `find . -type f -size +50M`
- If needed, use Git LFS for large files

### If you need to update later:
```bash
git add .
git commit -m "Update: [description of changes]"
git push
```

---

**Ready to proceed!** Follow steps 1-7 above to push your repository to GitHub.

