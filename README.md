# Gaming Peripherals Watch

Daily scan for (1) new gaming mice/keyboard announcements across all major brands and (2) Logitech-specific complaints and wishlist signals.

Published as a static site via GitHub Pages.

## Files
- `index.html` — landing page listing all reports.
- `about.html` — public About page (linked in nav).
- `sources.md` — brands and sources to track.
- `PROMPT.md` — the prompt Claude runs each day.
- `reports/YYYY-MM-DD.html` — one styled HTML report per day.
- `assets/style.css` · `assets/theme.js` — shared frontend assets.

## Viewing
Open `index.html` in a browser, or visit the GitHub Pages URL.

## Daily workflow

This project is generated half-automatically using the VSCode Claude Code extension. To produce today's report:

1. Open the project folder in VSCode.
2. In the Claude panel, ask:
   > 跑今天的報告,讀 PROMPT.md 照做,完成後 git add / git commit / git push 到 GitHub
   
   (Or in English: *Run today's report — read PROMPT.md and follow it, then git add / commit / push to GitHub.*)
3. Claude will perform the two web searches, write `reports/YYYY-MM-DD.html`, update `index.html`, and push the commit.
4. GitHub Pages will rebuild within ~1 minute.

### Requirements
- VSCode with the Claude Code extension signed in.
- Git for Windows installed, with credentials cached in Git Credential Manager (set up once on your first manual push).

## Tuning
- Too noisy? Tighten the brand list in `sources.md` or narrow the look-back window in `PROMPT.md`.
- Missing a source? Add it to `sources.md` — the prompt reads it each run.
