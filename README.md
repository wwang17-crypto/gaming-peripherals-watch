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
- `scripts/generate-daily.ps1` — runs Claude Code headlessly + commits + pushes.
- `scripts/register-task.ps1` — registers the Windows scheduled task.
- `logs/` — local run logs (gitignored).

## Viewing
Open `index.html` in a browser, or visit the GitHub Pages URL.

## Automated daily runs (Windows Task Scheduler)

### One-time setup
1. **Test the generator manually first** to confirm Claude auth + git push work:
   ```powershell
   cd d:\03_Claude\Research\gaming-peripherals-watch
   .\scripts\generate-daily.ps1
   ```
   Watch the output. If a new report appears on your Pages URL, you are good.

2. **Register the scheduled task** (default time: 09:30 daily — edit `$runTime` in `register-task.ps1` if you want a different time):
   ```powershell
   .\scripts\register-task.ps1
   ```

### Day-to-day
- Reports generate automatically. Check `logs\run-YYYY-MM-DD.log` if something looks off.
- **Manual trigger:** `Start-ScheduledTask -TaskName 'GamingPeripheralsWatch-DailyReport'`
- **Change time:** edit `$runTime` in `register-task.ps1` and re-run it (it overwrites the existing task).
- **Remove:** `Unregister-ScheduledTask -TaskName 'GamingPeripheralsWatch-DailyReport' -Confirm:$false`

### Requirements
- `claude` CLI installed at `%USERPROFILE%\.local\bin\claude.exe` (run `irm https://claude.ai/install.ps1 | iex` once in 64-bit PowerShell).
- Git for Windows installed at `C:\Program Files\Git\cmd\git.exe`, with credentials cached in Git Credential Manager (set up once on your first manual push).
- The script adds both tool paths explicitly, so Task Scheduler does not need them on the user PATH.
- PC must be on at the scheduled time. The task is registered with `StartWhenAvailable`, so if the PC was asleep it will fire as soon as it wakes.

### Fallback: half-auto via VSCode
If the scheduled task ever breaks, you can always run the day's report by opening the project in VSCode and asking the Claude extension:
> 跑今天的報告,讀 PROMPT.md 照做,完成後 git add / git commit / git push 到 GitHub

## Tuning
- Too noisy? Tighten the brand list in `sources.md` or narrow the look-back window in `PROMPT.md`.
- Missing a source? Add it to `sources.md` — the prompt reads it each run.
