# Gaming Peripherals Watch

Daily scan for (1) new gaming mice/keyboard announcements across all major brands and (2) Logitech-specific complaints and wishlist signals.

## Files
- `index.html` — landing page listing all reports (open this in a browser).
- `sources.md` — brands and sources to track. Edit this to add/remove targets.
- `PROMPT.md` — the prompt Claude runs each day. Edit to change scope.
- `reports/YYYY-MM-DD.html` — one styled HTML report per day.
- `assets/style.css` — shared stylesheet for all reports.

## Viewing
Open `index.html` directly in a browser. All reports are static HTML — no server needed.

## How to run

**Option A — one-off:** open this folder in Claude Code and say "run today's gaming peripherals watch" (Claude will read `PROMPT.md`).

**Option B — auto-pace while a session is open:** paste this:
```
/loop 24h Run today's gaming peripherals watch using d:\03_Claude\Research\gaming-peripherals-watch\PROMPT.md
```
Note: `/loop` only fires while a Claude session is running. It won't run unattended overnight.

**Option C — true daily unattended:** wire Claude Code CLI into Windows Task Scheduler. Ask me to set this up if you want it.

## Tuning
- Too noisy? Tighten the brand list in `sources.md` or narrow the look-back window in `PROMPT.md`.
- Missing a source? Add it to `sources.md` — the prompt reads that file each run.
