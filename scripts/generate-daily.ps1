# Runs Claude Code headlessly to generate today's report, then commits and pushes to GitHub.
# Designed for unattended execution via Windows Task Scheduler.

$ErrorActionPreference = "Stop"

# Task Scheduler does not inherit the interactive user's PATH reliably.
# Add the two tools we depend on explicitly.
$claudeBin = Join-Path $env:USERPROFILE ".local\bin"
$gitBin    = "C:\Program Files\Git\cmd"
if (Test-Path $claudeBin) { $env:Path = "$claudeBin;$env:Path" }
if (Test-Path $gitBin)    { $env:Path = "$gitBin;$env:Path" }

$projectPath = Split-Path $PSScriptRoot -Parent
Set-Location $projectPath

$today = Get-Date -Format "yyyy-MM-dd"
$startTime = Get-Date

New-Item -ItemType Directory -Force "logs" | Out-Null
$logFile = "logs\run-$today.log"

function Log($msg) {
    $line = "[$([DateTime]::Now.ToString('HH:mm:ss'))] $msg"
    Write-Host $line
    Add-Content -Path $logFile -Value $line -Encoding utf8
}

Log "=== Daily report generation: $today ==="
Log "Project: $projectPath"
Log "claude : $((Get-Command claude -ErrorAction SilentlyContinue).Source)"
Log "git    : $((Get-Command git    -ErrorAction SilentlyContinue).Source)"

$prompt = @"
Today is $today. Read PROMPT.md in this directory and execute its instructions fully: perform the two web searches, write the new report to reports/$today.html using the same HTML structure as reports/2026-05-20.html, and update index.html by prepending a new <li class="index-card"> entry for today. Do not ask for confirmation; proceed automatically. When done, print a one-line summary.
"@

Log "Invoking Claude Code..."

try {
    # Pipe $null into stdin so claude does not warn about missing stdin in non-interactive sessions.
    $null | & claude --print --dangerously-skip-permissions $prompt 2>&1 | ForEach-Object {
        Add-Content -Path $logFile -Value $_ -Encoding utf8
    }
} catch {
    Log "ERROR invoking claude: $_"
    exit 1
}

$reportFile = "reports\$today.html"
if (-not (Test-Path $reportFile)) {
    Log "ERROR: Expected report file $reportFile was not created. Aborting commit."
    exit 1
}

Log "Report generated: $reportFile"
Log "Committing to git..."

try {
    git add "reports/$today.html" "index.html" 2>&1 | Out-Null
    if ($LASTEXITCODE -ne 0) { Log "ERROR: git add failed"; exit 1 }

    git diff --cached --quiet
    if ($LASTEXITCODE -eq 0) {
        Log "No changes to commit. Exiting."
        exit 0
    }

    git commit -m "Daily report $today" 2>&1 | ForEach-Object { Add-Content -Path $logFile -Value $_ -Encoding utf8 }
    if ($LASTEXITCODE -ne 0) { Log "ERROR: git commit failed"; exit 1 }

    git push 2>&1 | ForEach-Object { Add-Content -Path $logFile -Value $_ -Encoding utf8 }
    if ($LASTEXITCODE -ne 0) { Log "ERROR: git push failed"; exit 1 }
} catch {
    Log "ERROR during git operations: $_"
    exit 1
}

$duration = [int]((Get-Date) - $startTime).TotalSeconds
Log "Done in ${duration}s. GitHub Pages will rebuild in ~1 minute."
