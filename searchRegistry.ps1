# Define the string to search for
$searchString = "your_search_string_here"

# Get all subkeys under the specified registry hive (e.g., HKEY_LOCAL_MACHINE)
$registryHive = [Microsoft.Win32.RegistryHive]::LocalMachine
$baseKey = [Microsoft.Win32.RegistryKey]::OpenBaseKey($registryHive, [Microsoft.Win32.RegistryView]::Default)
$subKeys = $baseKey.GetSubKeyNames()

# Loop through each subkey and search for the string in its values
foreach ($subKey in $subKeys) {
    $key = $baseKey.OpenSubKey($subKey)
    $valueNames = $key.GetValueNames()

    foreach ($valueName in $valueNames) {
        $value = $key.GetValue($valueName)

        if ($value -match $searchString) {
            Write-Host "Match found in $subKey\$valueName:"
            Write-Host "Value: $value"
            Write-Host ""
        }
    }
}

# Close the registry key
$baseKey.Close()
