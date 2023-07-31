# Check if the script is running with elevated privileges
if (-Not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "This script requires elevated privileges. Please run it as an administrator."
    exit 1
}

# Function to enable the Windows Firewall
function Enable-WindowsFirewall {
    $firewallProfiles = Get-NetFirewallProfile -All

    foreach ($profile in $firewallProfiles) {
        if (-Not $profile.Enabled) {
            Set-NetFirewallProfile -Name $profile.Name -Enabled True
            Write-Host "Firewall Profile '$($profile.Name)' has been enabled."
        }
    }
}

# Run the function to enable the Windows Firewall
Enable-WindowsFirewall
