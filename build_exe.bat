@echo off
echo ========================================
echo    File Size Analyzer - Build Script
echo ========================================
echo.

echo [1/4] Checking Python installation...
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Python not found!
    echo Please install Python 3.11 or later.
    pause
    exit /b 1
)
echo ✓ Python found

echo.
echo [2/4] Installing dependencies...
pip install -r requirements.txt
if %errorlevel% neq 0 (
    echo ERROR: Failed to install dependencies!
    pause
    exit /b 1
)
echo ✓ Dependencies installed

echo.
echo [3/4] Installing PyInstaller...
pip install pyinstaller
if %errorlevel% neq 0 (
    echo ERROR: Failed to install PyInstaller!
    pause
    exit /b 1
)
echo ✓ PyInstaller installed

echo.
echo [4/4] Building executable...
pyinstaller --clean main.spec
if %errorlevel% neq 0 (
    echo ERROR: Build failed!
    pause
    exit /b 1
)
echo ✓ Build completed successfully!

echo.
echo ========================================
echo    Build completed!
echo ========================================
echo.
echo Executable location: dist\FileSizeAnalyzer.exe
echo.
echo You can now run the executable directly.
echo.
pause 