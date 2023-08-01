# Configuration
$sourceDirectory = "C:\Path\To\Source"    # Replace with the source directory you want to back up
$backupDirectory = "C:\Path\To\Backup"    # Replace with the destination directory for backups
$logFile = "C:\Path\To\backup_log.txt"     # Replace with the path to the log file

# Function to get the last backup timestamp from the log file
function Get-LastBackupTime {
    if (Test-Path $logFile) {
        return (Get-Content $logFile | Select-Object -Last 1)
    } else {
        return $null
    }
}

# Function to update the last backup timestamp in the log file
function Update-LastBackupTime {
    $currentDate = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $currentDate | Out-File $logFile -Append
}

# Main script
$lastBackupTime = Get-LastBackupTime

if ($lastBackupTime -eq $null) {
    Write-Host "No previous backups found. Performing initial backup..."
    Update-LastBackupTime
} else {
    Write-Host "Last backup time: $lastBackupTime"
}

$filesToBackup = Get-ChildItem -Path $sourceDirectory -Recurse | Where-Object { $_.LastWriteTime -gt $lastBackupTime }

if ($filesToBackup.Count -eq 0) {
    Write-Host "No files to backup. Backup not needed."
} else {
    Write-Host "Files to backup:"
    $filesToBackup | ForEach-Object {
        Write-Host $_.FullName
        $destination = $_.FullName -replace [regex]::Escape($sourceDirectory), $backupDirectory
        $destinationFolder = Split-Path $destination -Parent

        if (-not (Test-Path $destinationFolder)) {
            New-Item -ItemType Directory -Path $destinationFolder -Force
        }

        Copy-Item $_.FullName -Destination $destination -Force
    }

    Update-LastBackupTime
    Write-Host "Backup completed."
}
