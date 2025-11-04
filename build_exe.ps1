Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   File Size Analyzer - Build Script" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "[1/4] Checking Python installation..." -ForegroundColor Yellow
try {
    $pythonVersion = python --version 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Python found: $pythonVersion" -ForegroundColor Green
    } else {
        throw "Python not found"
    }
} catch {
    Write-Host "ERROR: Python not found!" -ForegroundColor Red
    Write-Host "Please install Python 3.11 or later." -ForegroundColor Red
    Read-Host "Press Enter to continue"
    exit 1
}

Write-Host ""
Write-Host "[2/4] Installing dependencies..." -ForegroundColor Yellow
try {
    pip install -r requirements.txt
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Dependencies installed" -ForegroundColor Green
    } else {
        throw "Failed to install dependencies"
    }
} catch {
    Write-Host "ERROR: Failed to install dependencies!" -ForegroundColor Red
    Read-Host "Press Enter to continue"
    exit 1
}

Write-Host ""
Write-Host "[3/4] Installing PyInstaller..." -ForegroundColor Yellow
try {
    pip install pyinstaller
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ PyInstaller installed" -ForegroundColor Green
    } else {
        throw "Failed to install PyInstaller"
    }
} catch {
    Write-Host "ERROR: Failed to install PyInstaller!" -ForegroundColor Red
    Read-Host "Press Enter to continue"
    exit 1
}

Write-Host ""
Write-Host "[4/4] Building executable..." -ForegroundColor Yellow
try {
    pyinstaller --clean main.spec
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Build completed successfully!" -ForegroundColor Green
    } else {
        throw "Build failed"
    }
} catch {
    Write-Host "ERROR: Build failed!" -ForegroundColor Red
    Read-Host "Press Enter to continue"
    exit 1
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "    Build completed!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Executable location: dist\FileSizeAnalyzer.exe" -ForegroundColor White
Write-Host ""
Write-Host "You can now run the executable directly." -ForegroundColor Yellow
Write-Host ""

Read-Host "Press Enter to continue" 