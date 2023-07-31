# Check if the script is running with elevated privileges
if (-Not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "This script requires elevated privileges. Please run it as an administrator."
    exit 1
}

# Function to import a setting into the Registry
function Import-RegistrySetting {
    param (
        [string]$RegistryFilePath
    )

    if (-Not (Test-Path -Path $RegistryFilePath -PathType Leaf)) {
        Write-Host "The specified Registry file path does not exist."
        exit 1
    }

    try {
        # Use PowerShell's built-in cmdlet to import the Registry settings
        Write-Host "Importing Registry settings from: $RegistryFilePath"
        Invoke-Expression "reg import '$RegistryFilePath'"
        Write-Host "Registry settings imported successfully."
    } catch {
        Write-Host "An error occurred while importing the Registry settings: $_"
    }
}

# Example Usage:
# Replace 'C:\Path\To\Your\RegistryFile.reg' with the actual path of your .reg file.
Import-RegistrySetting -RegistryFilePath 'C:\Path\To\Your\RegistryFile.reg'
