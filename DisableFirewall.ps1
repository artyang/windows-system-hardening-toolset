# Check if the script is running with elevated privileges
if (-Not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "This script requires elevated privileges. Please run it as an administrator."
    exit 1
}

# Function to Disable the Windows Firewall
function Disable-WindowsFirewall {
    $firewallProfiles = Get-NetFirewallProfile -All

    foreach ($profile in $firewallProfiles) {
        if (-Not $profile.Disabled) {
            Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
            Write-Host "Firewall Profile '$($profile.Name)' has been Disabled."
        }
    }
}

# Run the function to Disable the Windows Firewall
Disable-WindowsFirewall
