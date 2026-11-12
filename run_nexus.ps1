# NEXUS Traffic AI Launcher (PowerShell)
Write-Host "======================================================================" -ForegroundColor Cyan
Write-Host "   NEXUS Traffic AI: RL Adaptive Traffic Management System" -ForegroundColor White
Write-Host "   Smart Mobility & Real-Time Traffic Optimization Platform" -ForegroundColor Green
Write-Host "======================================================================" -ForegroundColor Cyan

# Check Node in PATH or user directory
if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
    $userNode = "C:\Users\$env:USERNAME\nodejs"
    if (Test-Path $userNode) {
        $env:PATH = "$userNode;$env:PATH"
    }
}

$env:PYTHONPATH = ".;$env:PYTHONPATH"

# Verify dependencies
if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
    Write-Host "[ERROR] Node.js is required. Install from https://nodejs.org/" -ForegroundColor Red
    exit 1
}

if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
    Write-Host "[ERROR] Python is required. Install from https://python.org/" -ForegroundColor Red
    exit 1
}

# 1. Start backend
Write-Host "[1/2] Starting FastAPI Backend on http://127.0.0.1:8000 ..." -ForegroundColor Yellow
Start-Process powershell -ArgumentList "-NoExit", "-Command", "`$env:PYTHONPATH='.;' + `$env:PYTHONPATH; python -m uvicorn backend.main:app --host 127.0.0.1 --port 8000 --reload"

# 2. Start frontend
Write-Host "[2/2] Starting Vite React Frontend on http://127.0.0.1:5173 ..." -ForegroundColor Yellow
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd frontend; if (-not (Test-Path 'node_modules')) { npm install }; npm run dev"

Start-Sleep -Seconds 3

Write-Host ""
Write-Host "======================================================================" -ForegroundColor Green
Write-Host " NEXUS Traffic AI is now running successfully!" -ForegroundColor Green
Write-Host "  * Interactive Dashboard: http://127.0.0.1:5173/" -ForegroundColor Cyan
Write-Host "  * Backend API & Swagger: http://127.0.0.1:8000/docs" -ForegroundColor Cyan
Write-Host "======================================================================" -ForegroundColor Green

Start-Process "http://127.0.0.1:5173/"
