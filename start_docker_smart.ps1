Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   File Size Analyzer - Smart Docker Setup" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "[1/5] Checking Docker Desktop..." -ForegroundColor Yellow
try {
    $dockerVersion = docker --version 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Docker Desktop found: $dockerVersion" -ForegroundColor Green
    } else {
        throw "Docker not found"
    }
} catch {
    Write-Host "ERROR: Docker Desktop not found!" -ForegroundColor Red
    Write-Host "Please install and start Docker Desktop." -ForegroundColor Red
    Read-Host "Press Enter to continue"
    exit 1
}

Write-Host ""
Write-Host "[2/5] Checking Docker Compose..." -ForegroundColor Yellow
try {
    $composeVersion = docker-compose --version 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Docker Compose found: $composeVersion" -ForegroundColor Green
    } else {
        throw "Docker Compose not found"
    }
} catch {
    Write-Host "ERROR: Docker Compose not found!" -ForegroundColor Red
    Write-Host "Please update Docker Desktop." -ForegroundColor Red
    Read-Host "Press Enter to continue"
    exit 1
}

Write-Host ""
Write-Host "[3/5] Detecting available Windows drives..." -ForegroundColor Yellow
$availableDrives = @()
for ($i = 67; $i -le 90; $i++) {
    $driveLetter = [char]$i
    $drivePath = "$driveLetter`:\"
    if (Test-Path $drivePath) {
        $availableDrives += $driveLetter
        Write-Host "✓ Drive $driveLetter`: found" -ForegroundColor Green
    }
}

if ($availableDrives.Count -eq 0) {
    Write-Host "ERROR: No Windows drives found!" -ForegroundColor Red
    exit 1
}

Write-Host "Available drives: $($availableDrives -join ', ')" -ForegroundColor Cyan

Write-Host ""
Write-Host "[4/5] Creating dynamic docker-compose.yml..." -ForegroundColor Yellow

$composeContent = @"
version: '3.8'

services:
  streamlit-app:
    build: .
    container_name: file-size-analyzer
    ports:
      - "8502:8501"
    volumes:
"@

foreach ($drive in $availableDrives) {
    $driveLower = $drive.ToString().ToLower()
    $composeContent += "`n      - $drive`:/:/host/$driveLower`:ro"
}

$composeContent += @"
    environment:
      - STREAMLIT_SERVER_PORT=8501
      - STREAMLIT_SERVER_ADDRESS=0.0.0.0
      - STREAMLIT_SERVER_HEADLESS=true
      - STREAMLIT_SERVER_ENABLE_CORS=false
      - STREAMLIT_SERVER_ENABLE_XSRF_PROTECTION=false
      - STREAMLIT_BROWSER_GATHER_USAGE_STATS=false
    restart: unless-stopped
"@

$composeContent | Out-File -FilePath "docker-compose-temp.yml" -Encoding UTF8
Write-Host "✓ Dynamic docker-compose.yml created" -ForegroundColor Green

Write-Host ""
Write-Host "[5/5] Cleaning old containers..." -ForegroundColor Yellow
docker stop file-size-analyzer 2>$null
docker rm file-size-analyzer 2>$null
Write-Host "✓ Old containers cleaned" -ForegroundColor Green

Write-Host ""
Write-Host "🚀 Starting application..." -ForegroundColor Yellow
Write-Host ""
Write-Host "Creating and starting Docker container..." -ForegroundColor Cyan
Write-Host "This may take a few minutes..." -ForegroundColor Cyan
Write-Host ""

docker-compose -f docker-compose-temp.yml up --build

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "    Application started successfully!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Open this URL in your browser:" -ForegroundColor Yellow
Write-Host "http://localhost:8502" -ForegroundColor White
Write-Host ""
Write-Host "Press CTRL+C to stop the application" -ForegroundColor Yellow
Write-Host ""

Remove-Item "docker-compose-temp.yml" -ErrorAction SilentlyContinue

Read-Host "Press Enter to continue" 