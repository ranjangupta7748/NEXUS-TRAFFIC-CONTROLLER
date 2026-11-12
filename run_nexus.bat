@echo off
setlocal enabledelayedexpansion
echo ======================================================================
echo    NEXUS Traffic AI: RL Adaptive Traffic Management System
echo    Smart Mobility & Real-Time Traffic Optimization Platform
echo ======================================================================

REM Auto-detect Node.js in standard PATH or user directory
where node >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    if exist "C:\Users\%USERNAME%\nodejs" (
        set "PATH=C:\Users\%USERNAME%\nodejs;%PATH%"
    )
)

REM Set PYTHONPATH
set "PYTHONPATH=.%PYTHONPATH%"

echo.
echo [1/3] Verifying runtime dependencies...
node --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Node.js is not found. Please install Node.js from https://nodejs.org/
    pause
    exit /b 1
)

python --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Python is not found. Please install Python 3.10+ from https://python.org/
    pause
    exit /b 1
)

echo [2/3] Starting FastAPI Backend on http://127.0.0.1:8000 ...
start "NEXUS Backend API" cmd /k "python -m uvicorn backend.main:app --host 127.0.0.1 --port 8000 --reload"

echo [3/3] Starting Vite React Frontend on http://127.0.0.1:5173 ...
cd frontend
if not exist "node_modules\" (
    echo Installing frontend packages...
    call npm install
)
start "NEXUS Web Dashboard" cmd /k "npm run dev"

echo.
echo ======================================================================
echo  NEXUS Traffic AI is now running successfully!
echo.
echo  * Interactive Dashboard:  http://127.0.0.1:5173/
echo  * Backend API & Swagger:  http://127.0.0.1:8000/docs
echo  * City Focus:            Bengaluru, Karnataka, India
echo ======================================================================
echo.
timeout /t 3 >nul
start http://127.0.0.1:5173/
pause
