#!/usr/bin/env bash
echo "======================================================================"
echo "   NEXUS Traffic AI: RL Adaptive Traffic Management System"
echo "   Smart Mobility & Real-Time Traffic Optimization Platform"
echo "======================================================================"

export PYTHONPATH=".:$PYTHONPATH"

# 1. Start Backend
echo "[1/2] Starting FastAPI Backend on http://127.0.0.1:8000 ..."
python3 -m uvicorn backend.main:app --host 127.0.0.1 --port 8000 --reload &
BACKEND_PID=$!

# 2. Start Frontend
echo "[2/2] Starting Vite React Frontend on http://127.0.0.1:5173 ..."
cd frontend
if [ ! -d "node_modules" ]; then
    npm install
fi
npm run dev &
FRONTEND_PID=$!

echo ""
echo "======================================================================"
echo " NEXUS Traffic AI is now running!"
echo "  * Web Dashboard:  http://127.0.0.1:5173/"
echo "  * Backend API:    http://127.0.0.1:8000/docs"
echo "======================================================================"

trap "kill $BACKEND_PID $FRONTEND_PID; exit" SIGINT SIGTERM EXIT
wait
