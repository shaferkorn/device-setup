# Enable Hyper-V on a Windows Desktop System
# Run this script as Administrator

Write-Host "Checking for administrative privileges..." -ForegroundColor Yellow
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "This script must be run as Administrator!"
    Exit 1
}

Write-Host "Enabling Hyper-V and related features..." -ForegroundColor Cyan

$features = @(
    "Microsoft-Hyper-V-All",
    "Microsoft-Hyper-V-Management-PowerShell"
)

foreach ($feature in $features) {
    Write-Host "Enabling feature: $feature"
    Enable-WindowsOptionalFeature -Online -FeatureName $feature -All -NoRestart -ErrorAction Stop
}

Write-Host "`nAll required features enabled."
Write-Host "A system reboot is required for changes to take effect." -ForegroundColor Green

# Prompt for reboot
$reboot = Read-Host "Do you want to restart the computer now? (Y/N)"
if ($reboot -match '^[Yy]') {
    Restart-Computer
} else {
    Write-Host "Please reboot your computer manually later." -ForegroundColor Yellow
}
