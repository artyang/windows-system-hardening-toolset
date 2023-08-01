param (
    [string]$hostname,
    [string]$ipAddress
)

function Add-HostEntry {
    param (
        [string]$hostname,
        [string]$ipAddress
    )

    $hostsFilePath = "$env:SystemRoot\System32\drivers\etc\hosts"
    $entry = "$ipAddress`t$hostname"

    # Check if the entry already exists in the hosts file
    $existingEntries = Get-Content $hostsFilePath | Where-Object { $_ -match "^\s*($ipAddress\s+|$hostname\s+)" }

    if ($existingEntries.Count -eq 0) {
        # Append the new entry to the hosts file
        Add-Content -Path $hostsFilePath -Value $entry
        Write-Host "Entry added successfully."
    } else {
        Write-Host "The entry already exists in the hosts file."
    }
}

# Check if the script is run with administrator privileges
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Please run this script with administrative privileges."
    exit 1
}

# Validate input parameters
if (-not $hostname -or -not $ipAddress) {
    Write-Host "Usage: Add-HostEntry -hostname <hostname> -ipAddress <ipAddress>"
    exit 1
}

Add-HostEntry -hostname $hostname -ipAddress $ipAddress
