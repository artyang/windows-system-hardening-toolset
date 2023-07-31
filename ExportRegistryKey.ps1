# Check if the script is running with elevated privileges
if (-Not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "This script requires elevated privileges. Please run it as an administrator."
    exit 1
}

# Function to export a registry key to a .reg file
function Export-RegistryKey {
    param (
        [string]$RegistryKeyPath,
        [string]$ExportFilePath
    )

    if (-Not (Test-Path -Path $RegistryKeyPath -PathType Container)) {
        Write-Host "The specified Registry key path does not exist."
        exit 1
    }

    try {
        # Use PowerShell's built-in cmdlet to export the Registry key
        Write-Host "Exporting Registry key to: $ExportFilePath"
        reg export "$RegistryKeyPath" "$ExportFilePath" /y
        Write-Host "Registry key exported successfully."
    } catch {
        Write-Host "An error occurred while exporting the Registry key: $_"
    }
}

# Example Usage:
# Replace 'HKLM:\Software\YourKeyName' with the actual path of the Registry key you want to export.
# Replace 'C:\Path\To\Your\ExportFile.reg' with the desired path and filename for the .reg file.
Export-RegistryKey -RegistryKeyPath 'HKLM:\Software\YourKeyName' -ExportFilePath 'C:\Path\To\Your\ExportFile.reg'
