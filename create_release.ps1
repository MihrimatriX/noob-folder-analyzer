Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   File Size Analyzer - Release Creator" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "[1/5] Checking Git installation..." -ForegroundColor Yellow
try {
    $gitVersion = git --version 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Git found: $gitVersion" -ForegroundColor Green
    } else {
        throw "Git not found"
    }
} catch {
    Write-Host "ERROR: Git not found!" -ForegroundColor Red
    Write-Host "Please install Git." -ForegroundColor Red
    Read-Host "Press Enter to continue"
    exit 1
}

Write-Host ""
Write-Host "[2/5] Building executable..." -ForegroundColor Yellow
try {
    & .\build_exe.ps1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Build completed" -ForegroundColor Green
    } else {
        throw "Build failed"
    }
} catch {
    Write-Host "ERROR: Build failed!" -ForegroundColor Red
    Read-Host "Press Enter to continue"
    exit 1
}

Write-Host ""
Write-Host "[3/5] Creating release package..." -ForegroundColor Yellow
$version = "1.0.0"
$archiveName = "FileSizeAnalyzer-v$version-Windows.zip"

if (Test-Path $archiveName) {
    Remove-Item $archiveName -Force
}

try {
    Compress-Archive -Path "dist\FileSizeAnalyzer.exe" -DestinationPath $archiveName
    Write-Host "✓ Release package created: $archiveName" -ForegroundColor Green
} catch {
    Write-Host "ERROR: Failed to create ZIP archive!" -ForegroundColor Red
    Read-Host "Press Enter to continue"
    exit 1
}

Write-Host ""
Write-Host "[4/5] Creating Git tag..." -ForegroundColor Yellow
try {
    git add .
    git commit -m "Release v$version - Windows executable" 2>$null
    git tag -a "v$version" -m "Release v$version"
    Write-Host "✓ Git operations completed" -ForegroundColor Green
} catch {
    Write-Host "WARNING: Git operations failed. You may need to configure Git." -ForegroundColor Yellow
    Write-Host "Please run manually:" -ForegroundColor Yellow
    Write-Host "  git add ." -ForegroundColor White
    Write-Host "  git commit -m `"Release v$version`"" -ForegroundColor White
    Write-Host "  git tag -a `"v$version`" -m `"Release v$version`"" -ForegroundColor White
    Write-Host "  git push origin main" -ForegroundColor White
    Write-Host "  git push origin v$version" -ForegroundColor White
}

Write-Host ""
Write-Host "[5/5] Release Summary" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Version: v$version" -ForegroundColor White
Write-Host "Executable: dist\FileSizeAnalyzer.exe" -ForegroundColor White
Write-Host "Package: $archiveName" -ForegroundColor White
$fileSize = (Get-Item $archiveName).Length
Write-Host "Size: $fileSize bytes" -ForegroundColor White
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. Push to GitHub: git push origin main" -ForegroundColor White
Write-Host "2. Push tag: git push origin v$version" -ForegroundColor White
Write-Host "3. GitHub Actions will automatically create release" -ForegroundColor White
Write-Host "4. Or manually upload $archiveName to GitHub releases" -ForegroundColor White
Write-Host ""

Read-Host "Press Enter to continue" 