@echo off
echo ========================================
echo    File Size Analyzer - Release Creator
echo ========================================
echo.

echo [1/5] Checking Git installation...
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Git not found!
    echo Please install Git.
    pause
    exit /b 1
)
echo ✓ Git found

echo.
echo [2/5] Building executable...
call build_exe.bat
if %errorlevel% neq 0 (
    echo ERROR: Build failed!
    pause
    exit /b 1
)
echo ✓ Build completed

echo.
echo [3/5] Creating release package...
set "version=1.0.0"
set "archiveName=FileSizeAnalyzer-v%version%-Windows.zip"

if exist "%archiveName%" del "%archiveName%"

powershell -Command "Compress-Archive -Path 'dist\FileSizeAnalyzer.exe' -DestinationPath '%archiveName%'"
if %errorlevel% neq 0 (
    echo ERROR: Failed to create ZIP archive!
    pause
    exit /b 1
)
echo ✓ Release package created: %archiveName%

echo.
echo [4/5] Creating Git tag...
git add .
git commit -m "Release v%version% - Windows executable" 2>nul
git tag -a "v%version%" -m "Release v%version%"
if %errorlevel% neq 0 (
    echo WARNING: Git operations failed. You may need to configure Git.
    echo Please run manually:
    echo   git add .
    echo   git commit -m "Release v%version%"
    echo   git tag -a "v%version%" -m "Release v%version%"
    echo   git push origin main
    echo   git push origin v%version%
)

echo.
echo [5/5] Release Summary
echo ========================================
echo Version: v%version%
echo Executable: dist\FileSizeAnalyzer.exe
echo Package: %archiveName%
echo Size: 
for %%A in ("%archiveName%") do echo   %%~zA bytes
echo.
echo Next steps:
echo 1. Push to GitHub: git push origin main
echo 2. Push tag: git push origin v%version%
echo 3. GitHub Actions will automatically create release
echo 4. Or manually upload %archiveName% to GitHub releases
echo.
pause 