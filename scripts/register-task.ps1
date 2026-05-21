# Registers a Windows Task Scheduler entry that runs generate-daily.ps1 every day.
# Run this once (not as Admin — uses your user account so git credentials work).
# Edit $runTime below to change when it fires.

$taskName = "GamingPeripheralsWatch-DailyReport"
$runTime = "09:30"

$scriptPath = Join-Path $PSScriptRoot "generate-daily.ps1"
if (-not (Test-Path $scriptPath)) {
    Write-Error "generate-daily.ps1 not found at $scriptPath"
    exit 1
}

$action = New-ScheduledTaskAction `
    -Execute "powershell.exe" `
    -Argument "-NoProfile -ExecutionPolicy Bypass -File `"$scriptPath`"" `
    -WorkingDirectory (Split-Path $scriptPath -Parent)

$trigger = New-ScheduledTaskTrigger -Daily -At $runTime

$settings = New-ScheduledTaskSettingsSet `
    -StartWhenAvailable `
    -RunOnlyIfNetworkAvailable `
    -ExecutionTimeLimit (New-TimeSpan -Minutes 15) `
    -AllowStartIfOnBatteries `
    -DontStopIfGoingOnBatteries

$principal = New-ScheduledTaskPrincipal `
    -UserId "$env:USERDOMAIN\$env:USERNAME" `
    -LogonType Interactive `
    -RunLevel Limited

$existing = Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue
if ($existing) {
    Write-Host "Removing existing task '$taskName'..."
    Unregister-ScheduledTask -TaskName $taskName -Confirm:$false
}

Register-ScheduledTask `
    -TaskName $taskName `
    -Action $action `
    -Trigger $trigger `
    -Settings $settings `
    -Principal $principal `
    -Description "Generate and push the daily gaming peripherals watch report."

Write-Host ""
Write-Host "Registered: $taskName"
Write-Host "Runs daily at: $runTime"
Write-Host "Script: $scriptPath"
Write-Host ""
Write-Host "Manage in Task Scheduler: taskschd.msc → Task Scheduler Library → $taskName"
Write-Host "Test now: Start-ScheduledTask -TaskName '$taskName'"
Write-Host "Remove later: Unregister-ScheduledTask -TaskName '$taskName' -Confirm:`$false"
