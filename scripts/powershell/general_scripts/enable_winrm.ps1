# Check if WinRM is already enabled
if ((Get-Service "winrm").Status -eq "Running") {
    Write-Host "WinRM is already enabled."
    exit
}

# Enable WinRM
Enable-PSRemoting -Force

# Set the WinRM service to start automatically
Set-Service "winrm" -StartupType Automatic

# Open the WinRM firewall port
New-NetFirewallRule -DisplayName "WinRM" -Direction Inbound -LocalPort 5985 -Protocol TCP -RemoteAddress Any -Action Allow

# Restart the WinRM service to apply changes
Restart-Service "winrm"