@echo off
setlocal enabledelayedexpansion

echo ========================================
echo    File Size Analyzer - Smart Docker Setup
echo ========================================
echo.

echo [1/5] Checking Docker Desktop...
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Docker Desktop not found!
    echo Please install and start Docker Desktop.
    pause
    exit /b 1
)
echo ✓ Docker Desktop found

echo.
echo [2/5] Checking Docker Compose...
docker-compose --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Docker Compose not found!
    echo Please update Docker Desktop.
    pause
    exit /b 1
)
echo ✓ Docker Compose found

echo.
echo [3/5] Detecting available Windows drives...
set "available_drives="
for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%d:\" (
        echo ✓ Drive %%d: found
        set "available_drives=!available_drives! %%d"
    )
)

if "%available_drives%"=="" (
    echo ERROR: No Windows drives found!
    pause
    exit /b 1
)

echo Available drives:%available_drives%

echo.
echo [4/5] Creating dynamic docker-compose.yml...

echo version: '3.8' > docker-compose-temp.yml
echo. >> docker-compose-temp.yml
echo services: >> docker-compose-temp.yml
echo   streamlit-app: >> docker-compose-temp.yml
echo     build: . >> docker-compose-temp.yml
echo     container_name: file-size-analyzer >> docker-compose-temp.yml
echo     ports: >> docker-compose-temp.yml
echo       - "8502:8501" >> docker-compose-temp.yml
echo     volumes: >> docker-compose-temp.yml

for %%d in (%available_drives%) do (
    echo       - %%d:/:/host/%%d:ro >> docker-compose-temp.yml
)

echo     environment: >> docker-compose-temp.yml
echo       - STREAMLIT_SERVER_PORT=8501 >> docker-compose-temp.yml
echo       - STREAMLIT_SERVER_ADDRESS=0.0.0.0 >> docker-compose-temp.yml
echo       - STREAMLIT_SERVER_HEADLESS=true >> docker-compose-temp.yml
echo       - STREAMLIT_SERVER_ENABLE_CORS=false >> docker-compose-temp.yml
echo       - STREAMLIT_SERVER_ENABLE_XSRF_PROTECTION=false >> docker-compose-temp.yml
echo       - STREAMLIT_BROWSER_GATHER_USAGE_STATS=false >> docker-compose-temp.yml
echo     restart: unless-stopped >> docker-compose-temp.yml

echo ✓ Dynamic docker-compose.yml created

echo.
echo [5/5] Cleaning old containers...
docker stop file-size-analyzer >nul 2>&1
docker rm file-size-analyzer >nul 2>&1
echo ✓ Old containers cleaned

echo.
echo 🚀 Starting application...
echo.
echo Creating and starting Docker container...
echo This may take a few minutes...
echo.

docker-compose -f docker-compose-temp.yml up --build

echo.
echo ========================================
echo    Application started successfully!
echo ========================================
echo.
echo Open this URL in your browser:
echo http://localhost:8502
echo.
echo Press CTRL+C to stop the application
echo.

del docker-compose-temp.yml >nul 2>&1

pause 