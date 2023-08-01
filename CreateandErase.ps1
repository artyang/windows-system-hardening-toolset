param(
    [string]$sourceDirectory = "C:\Path\To\Source",     # Replace with the source directory you want to compress and erase
    [string]$backupDirectory = "C:\Path\To\Backup"     # Replace with the destination directory for the compressed backup
)

function Compress-Directory {
    param (
        [string]$sourcePath,
        [string]$destinationPath
    )

    Add-Type -assembly "System.IO.Compression.FileSystem"
    [IO.Compression.ZipFile]::CreateFromDirectory($sourcePath, $destinationPath)
}

function Remove-DirectoryContents {
    param (
        [string]$directoryPath
    )

    Get-ChildItem $directoryPath -Force | Remove-Item -Recurse -Force
}

# Main script
if (-not (Test-Path $sourceDirectory)) {
    Write-Host "Source directory not found: $sourceDirectory"
    exit 1
}

if (-not (Test-Path $backupDirectory)) {
    Write-Host "Backup directory not found: $backupDirectory"
    exit 1
}

$sourceDirectoryName = (Get-Item $sourceDirectory).Name
$backupFileName = "$backupDirectory\$sourceDirectoryName-$(Get-Date -Format 'yyyyMMdd-HHmmss').zip"

Write-Host "Compressing directory: $sourceDirectory"
Compress-Directory -sourcePath $sourceDirectory -destinationPath $backupFileName

Write-Host "Erasing directory contents: $sourceDirectory"
Remove-DirectoryContents -directoryPath $sourceDirectory

Write-Host "Backup completed and directory contents erased."
