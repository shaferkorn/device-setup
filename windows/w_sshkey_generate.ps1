$email = Read-Host "Enter your email for the SSH key"
ssh-keygen -t ed25519 -C $email

Get-Content $env:USERPROFILE\.ssh\id_ed25519.pub | Set-Clipboard
Write-Host "SSH key copied to Clipboard!"