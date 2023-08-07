# Get a list of local user accounts
$localAccounts = Get-WmiObject Win32_UserAccount | Where-Object { $_.LocalAccount -eq $true }

# Display information for each local user account
foreach ($account in $localAccounts) {
    $accountName = $account.Name
    $accountType = $account.AccountType
    $fullName = $account.FullName
    $status = $account.Disabled

    Write-Host "Account Name: $accountName"
    Write-Host "Account Type: $accountType"
    Write-Host "Full Name: $fullName"
    Write-Host "Account Status: $($status -eq $true ? 'Disabled' : 'Enabled')"
    Write-Host ""
}
