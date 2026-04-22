# Start logging the session
Start-Transcript -Path "$HOME\Desktop\restoration_log.txt"

# Load the list of files to be replaced
$fileListPath = "$HOME\Desktop\files.txt"
if (-not (Test-Path $fileListPath)) {
    Write-Error "File list not found at $fileListPath"
    Stop-Transcript
    return
}

$fileList = Get-Content $fileListPath

foreach ($relPath in $fileList) {
    $relPathClean = $relPath.Trim()
    
    # ADJUST PATH LOGIC HERE:
    # Example: If your list starts with "wfiles\" but your target doesn't, we strip it.
    $relPathNormalized = $relPathClean -replace '^wfiles\\', ''

    # CONFIGURE YOUR DRIVES HERE:
    $src = "Z:\WFILES\" + $relPathNormalized  # Recovery/Backup Drive
    $dst = "W:\" + $relPathNormalized         # Live/Corrupted Drive

    try {
        if (-not (Test-Path $src)) {
            Write-Host "[FAIL] NOT FOUND in Source (Z): $relPathClean" -ForegroundColor Yellow
        }
        elseif (-not (Test-Path $dst)) {
            # This check ensures we don't copy files that aren't already on the live drive
            Write-Host "[SKIP] DOES NOT EXIST in Destination (W): $relPathClean - Replacement skipped." -ForegroundColor Cyan
        }
        else {
            # Perform the 1:1 Replacement
            Copy-Item $src -Destination $dst -Force -ErrorAction Stop
            Write-Host "[OK] Successfully Replaced: $relPathClean" -ForegroundColor Green
        }
    }
    catch {
        Write-Host "[ERROR] $relPathClean - $($_.Exception.Message)" -ForegroundColor Red
    }
}

Stop-Transcript