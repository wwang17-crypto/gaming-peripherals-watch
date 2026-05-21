# Gaming Peripherals Watch

Daily scan for (1) new gaming mice/keyboard announcements across all major brands and (2) Logitech-specific complaints and wishlist signals.

## Files
- `index.html` — landing page listing all reports.
- `about.html` — public About page (linked in nav).
- `sources.md` — brands and sources to track.
- `PROMPT.md` — the prompt Claude runs each day.
- `reports/YYYY-MM-DD.html` — one styled HTML report per day.
- `assets/style.css` · `assets/theme.js` — shared frontend assets.
- `scripts/generate-daily.ps1` — runs Claude Code headlessly + commits + pushes.
- `scripts/register-task.ps1` — registers the Windows scheduled task.
- `logs/` — local run logs (gitignored).

## Viewing
Open `index.html` in a browser, or visit the GitHub Pages URL.

## Automated daily runs

### One-time setup
1. **Test the generator manually first** to make sure auth + git push work:
   ```powershell
   cd d:\03_Claude\Research\gaming-peripherals-watch
   .\scripts\generate-daily.ps1
   ```
   Watch the output. If it completes and a new report appears on your Pages URL, you're good.

2. **Register the scheduled task** (default time: 8:33 AM daily — edit `$runTime` in the script first if you want a different time):
   ```powershell
   .\scripts\register-task.ps1
   ```

### Day-to-day
- Reports generate automatically. Check `logs/run-YYYY-MM-DD.log` if something looks off.
- **Manual trigger:** `Start-ScheduledTask -TaskName 'GamingPeripheralsWatch-DailyReport'`
- **Change time:** edit `$runTime` in `register-task.ps1` and re-run it (it overwrites the existing task).
- **Remove:** `Unregister-ScheduledTask -TaskName 'GamingPeripheralsWatch-DailyReport' -Confirm:$false`

### Requirements
- `claude` CLI on PATH (you already have it).
- `git` configured with credentials that can push to your repo (Windows Credential Manager handles this after your first manual push).
- PC must be on at the scheduled time. Task Scheduler is set to `StartWhenAvailable`, so if the PC was asleep it will fire as soon as it wakes.

## Tuning
- Too noisy? Tighten the brand list in `sources.md` or narrow the look-back window in `PROMPT.md`.
- Missing a source? Add it to `sources.md` — the prompt reads it each run.
