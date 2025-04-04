@echo off
echo Installing Node.js dependencies...
cd /d C:\Users\xmyoc\OneDrive\Documents\GitHub\pixel-art-generator
echo Running: npm install
npm install
if %ERRORLEVEL% neq 0 (
    echo Error: npm install failed. Make sure Node.js is installed.
    echo You can download Node.js from: https://nodejs.org/
    pause
    exit /b
)
echo.
echo Dependencies installed successfully!
echo.
echo Starting the application...
echo Running: npm run dev
npm run dev
echo.
echo If the application started successfully, open your web browser
echo and navigate to: http://localhost:3000
echo.
echo Press Ctrl+C to stop the application when done.