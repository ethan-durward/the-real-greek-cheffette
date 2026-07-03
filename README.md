# ✦ The Real Greek Cheffette

A clean, modern recipe website with a built-in admin panel. Recipes are stored in `data.json` — this file *is* the database. The admin page commits changes directly to this file via the GitHub API, so your website updates automatically whenever a recipe is saved.

---

## Files

| File | Purpose |
|------|---------|
| `index.html` | The public-facing website visitors see |
| `admin.html` | Password-protected recipe management panel |
| `data.json` | **The recipe database** — all recipe data lives here |
| `setup.sh` | One-time script to create the GitHub repo and push everything |

---

## Quick Start

### 1. Run the setup script (once)

Open **Terminal** on your Mac, `cd` into the folder containing these files, then run:

```bash
bash setup.sh
```

The script will:
- Ask for your GitHub Personal Access Token
- Create the `the-real-greek-cheffette` repository
- Push all files to GitHub

### 2. Enable GitHub Pages (to host the site)

1. Go to `https://github.com/ethan-durward/the-real-greek-cheffette`
2. Click **Settings** → **Pages**
3. Under *Source*, select **Deploy from a branch** → **main** → **/ (root)**
4. Click **Save**

Your site will be live at:
```
https://ethan-durward.github.io/the-real-greek-cheffette/
```

> **Note:** GitHub Pages is free for public repositories. For private repos it requires a paid GitHub plan. Alternatively, drag the folder into [Netlify Drop](https://app.netlify.com/drop) for instant free hosting that works with private repos too.

---

## Using the Admin Panel

### Logging in

Open `admin.html` in your browser (or visit `your-site-url/admin.html`).

**Default password:** `cheffette`

To change it, open `admin.html` in a text editor and find this line near the top of the `<script>` section:
```javascript
const ADMIN_PASSWORD = 'cheffette';
```
Change `'cheffette'` to any password you like, save, and push the file to GitHub.

### Connecting to GitHub (first time)

After logging in, a **Connect to GitHub** banner will appear. Fill in:

- **GitHub Username:** `ethan-durward`
- **Repository Name:** `the-real-greek-cheffette`
- **Personal Access Token:** your `ghp_…` token

Click **Save & Connect**. These details are stored only in your browser — they are never written into any file in the repo.

Once connected, the **Save & Publish** button commits recipe changes straight to `data.json` in GitHub. The public website updates within seconds.

### Adding / editing a recipe

1. Click **Add Recipe** (or the **Edit** button on any recipe)
2. Fill in the form — title, category, description, photo, ingredients, instructions, and optionally an Instagram reel link
3. Click **Save & Publish**

Photos are compressed automatically before saving. They are stored as base64 inside `data.json`.

> **Tip:** If saving fails with a large photo, try cropping or resizing the image before uploading.

---

## Recipe Data Structure

Each recipe in `data.json` looks like this:

```json
{
  "id": "r1",
  "title": "Classic Horiatiki",
  "category": "Salads",
  "description": "Short teaser text shown on the recipe card.",
  "image": "data:image/jpeg;base64,…",
  "instagram": "https://www.instagram.com/reel/…",
  "prepTime": "10 min",
  "cookTime": "0 min",
  "serves": "4",
  "featured": true,
  "ingredients": ["item one", "item two"],
  "instructions": ["Step one.", "Step two."],
  "createdAt": "2025-01-01T10:00:00Z",
  "updatedAt": "2025-06-01T12:00:00Z"
}
```

You can also edit `data.json` directly in GitHub's web editor if you ever need to make a quick fix.

---

## Backing Up Your Recipes

Because `data.json` is in a Git repository, every save is automatically version-controlled. You can:

- See the full history of changes at `github.com/ethan-durward/the-real-greek-cheffette/commits/main`
- Restore any previous version by clicking on a commit and downloading that version of `data.json`

---

## Changing the Admin Password

Open `admin.html`, find:
```javascript
const ADMIN_PASSWORD = 'cheffette';
```
Change the value, save, and push to GitHub.

---

## Hosting Options

| Option | Cost | Notes |
|--------|------|-------|
| GitHub Pages | Free (public repos) | Automatic, no config needed beyond enabling it |
| [Netlify Drop](https://app.netlify.com/drop) | Free | Drag-and-drop, supports private repos |
| Any web host | Varies | Upload `index.html`, `admin.html`, and `data.json` via FTP |

---

*Built with love for The Real Greek Cheffette 🫒*
