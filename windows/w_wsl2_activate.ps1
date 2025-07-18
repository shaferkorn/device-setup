# Run this script as Administrator

# Enable required features
Write-Host "Enabling WSL and Virtual Machine Platform..." -ForegroundColor Cyan
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

# Enable the Virtual Machine Platform feature (required for WSL 2)
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# Set WSL2 as the default
Write-Host "Setting WSL version 2 as default..." -ForegroundColor Cyan
wsl --set-default-version 2

# Install WSL kernel update if not already installed
$kernelInstallerUrl = "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi"
$kernelInstallerPath = "$env:TEMP\wsl_update_x64.msi"

if (!(Test-Path $kernelInstallerPath)) {
    Write-Host "Downloading WSL2 kernel update..." -ForegroundColor Cyan
    Invoke-WebRequest -Uri $kernelInstallerUrl -OutFile $kernelInstallerPath
}

Write-Host "Installing WSL2 kernel update..." -ForegroundColor Cyan
Start-Process msiexec.exe -Wait -ArgumentList "/i `"$kernelInstallerPath`" /quiet /norestart"

Write-Host "Installing wsl..." -ForegroundColor Cyan
wsl --install

Write-Host "`nWSL2 setup complete. Please restart your computer to apply all changes." -ForegroundColor Green
Start-Sleep -Seconds 10
