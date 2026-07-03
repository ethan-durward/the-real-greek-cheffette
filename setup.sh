#!/bin/bash
# ─────────────────────────────────────────────────────────
#  The Real Greek Cheffette — one-time GitHub setup script
#  Run from inside the project folder:  bash setup.sh
# ─────────────────────────────────────────────────────────

OWNER="ethan-durward"
REPO="the-real-greek-cheffette"

echo ""
echo "✦ The Real Greek Cheffette — GitHub Setup"
echo "─────────────────────────────────────────"
echo ""
echo "Paste your GitHub Personal Access Token and press Enter"
echo "(the token won't be visible as you type — that's normal):"
echo ""
read -s GITHUB_TOKEN
echo ""

if [ -z "$GITHUB_TOKEN" ]; then
  echo "✗ No token provided. Exiting."
  exit 1
fi

# ── 1. Create the repository ──────────────────────────────
echo "→ Creating repository '$REPO'…"
RESPONSE=$(curl -s -w "\n%{http_code}" -X POST https://api.github.com/user/repos \
  -H "Authorization: token $GITHUB_TOKEN" \
  -H "Content-Type: application/json" \
  -d "{\"name\":\"$REPO\",\"description\":\"The Real Greek Cheffette recipe website\",\"private\":true,\"auto_init\":false}")

HTTP_CODE=$(echo "$RESPONSE" | tail -1)
BODY=$(echo "$RESPONSE" | head -1)

if [ "$HTTP_CODE" = "201" ]; then
  echo "  ✓ Repository created."
elif echo "$BODY" | grep -q "already exists"; then
  echo "  ✓ Repository already exists — continuing."
else
  echo "  ✗ Failed to create repository (HTTP $HTTP_CODE)."
  echo "  Response: $BODY"
  echo ""
  echo "  Check that your token has the 'repo' scope."
  exit 1
fi

# ── 2. Initialise git ─────────────────────────────────────
echo "→ Initialising git repository…"
git init -q
git add .
git commit -q -m "Initial commit — The Real Greek Cheffette"
git branch -M main

# ── 3. Push to GitHub ─────────────────────────────────────
echo "→ Pushing files to GitHub…"
REMOTE="https://${GITHUB_TOKEN}@github.com/${OWNER}/${REPO}.git"
git remote remove origin 2>/dev/null
git remote add origin "$REMOTE"
git push -u origin main --quiet

if [ $? -eq 0 ]; then
  echo ""
  echo "─────────────────────────────────────────"
  echo "✓ All done!"
  echo ""
  echo "  Repository:  https://github.com/$OWNER/$REPO"
  echo ""
  echo "  Next step — enable GitHub Pages:"
  echo "  1. Open the link above"
  echo "  2. Go to Settings → Pages"
  echo "  3. Source: Deploy from branch → main → / (root)"
  echo "  4. Click Save"
  echo ""
  echo "  Your site will be live at:"
  echo "  https://$OWNER.github.io/$REPO/"
  echo "─────────────────────────────────────────"
else
  echo ""
  echo "✗ Push failed. Check your token and try again."
  exit 1
fi
