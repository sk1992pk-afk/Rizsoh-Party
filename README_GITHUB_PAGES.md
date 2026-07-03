# MR BOSS GitHub Pages Hosting Pack

## What this package is
This is a static web demo of **MR BOSS** prepared for **GitHub Pages** hosting.

## Files
- `index.html`
- `styles.css`
- `app.js`
- `.nojekyll`

## Fastest deploy steps
### Option A — Upload through GitHub website
1. Create a new GitHub repository, for example: `mr-boss-web-demo`
2. Upload **all files from this folder** to the repository root
3. Go to **Settings → Pages**
4. Under **Build and deployment**:
   - Source: **Deploy from a branch**
   - Branch: **main**
   - Folder: **/ (root)**
5. Save
6. GitHub will generate a live URL like:
   `https://YOUR_USERNAME.github.io/mr-boss-web-demo/`

### Option B — Push with Git locally
```bash
git init
git add .
git commit -m "MR BOSS web demo"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/mr-boss-web-demo.git
git push -u origin main
```

Then enable **Pages** in repository settings.

## Important
This is a browser demo / preview package, not the Android APK.
