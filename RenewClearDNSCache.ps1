# Check if the script is running with elevated privileges
if (-Not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "This script requires elevated privileges. Please run it as an administrator."
    exit 1
}

# Function to renew and clear the DNS cache
function Renew-Clear-DnsCache {
    # Renew DNS cache
    Write-Host "Renewing DNS Cache..."
    ipconfig /flushdns

    # Clear DNS cache using PowerShell
    Write-Host "Clearing DNS Cache using PowerShell..."
    Clear-DnsClientCache

    # Display completion message
    Write-Host "DNS Cache Renewed and Cleared Successfully!"
}

# Run the function to renew and clear the DNS cache
Renew-Clear-DnsCache
