# Set download URL and target path
$installerUrl = "https://github.com/git-for-windows/git/releases/download/v2.50.1.windows.1/Git-2.50.1-64-bit.exe"
$installerPath = "$env:TEMP\Git-2.50.1-64-bit.exe"

# Download the MSI installer
Write-Host "Downloading GitWindows installer..."
Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath

# Check if download succeeded
if (Test-Path $installerPath) {
    Write-Host "Download complete. Launching installer..."
    
    # Run the installer
    Start-Process -FilePath $installerPath -Wait

    Write-Host "Installer launched."
} else {
    Write-Error "Failed to download the installer."
}
