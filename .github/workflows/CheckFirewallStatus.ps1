# Check if the script is running with elevated privileges
if (-Not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "This script requires elevated privileges. Please run it as an administrator."
    exit 1
}

# Function to check the Windows Firewall status
function Get-FirewallStatus {
    $firewallStatus = Get-NetFirewallProfile

    foreach ($profile in $firewallStatus) {
        $profileName = $profile.Name
        $enabled = $profile.Enabled
        $status = if ($enabled) { "Enabled" } else { "Disabled" }

        Write-Host "Firewall Profile: $profileName"
        Write-Host "Status: $status"
        Write-Host ""
    }
}

# Run the function to check the firewall status
Get-FirewallStatus
