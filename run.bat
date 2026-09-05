@echo off
setlocal
title How LLMs Work

REM Double-click this file to:
REM   1. pull the latest version of the repository
REM   2. install any new dependencies
REM   3. start the dev server and open the app in your default browser
REM Close this window to stop the server.

cd /d "%~dp0"

where git >nul 2>&1 || (
  echo Git is not installed or not on your PATH.
  echo Install it from https://git-scm.com/download/win and run this file again.
  pause
  exit /b 1
)
where node >nul 2>&1 || (
  echo Node.js is not installed or not on your PATH. Node.js 20 or newer is required.
  echo Install it from https://nodejs.org and run this file again.
  pause
  exit /b 1
)
where pnpm >nul 2>&1 || (
  echo pnpm is not installed or not on your PATH.
  echo Install it with:  npm install -g pnpm   ^(or see https://pnpm.io/installation^)
  pause
  exit /b 1
)

REM Everything below runs as ONE block. cmd.exe parses the whole block before
REM executing it, so the script keeps working even when "git pull" replaces
REM this very file with a newer version.
(
  echo.
  echo [1/3] Updating repository...
  git pull --ff-only
  if errorlevel 1 (
    echo.
    echo WARNING: Could not update the repository ^(see the message above^).
    echo          Continuing with the files already on this machine.
    echo.
  )

  echo.
  echo [2/3] Installing dependencies...
  call pnpm install
  if errorlevel 1 (
    echo.
    echo ERROR: pnpm install failed. Fix the error above and run this file again.
    pause
    exit /b 1
  )

  echo.
  echo [3/3] Starting the dev server. Your browser will open automatically.
  echo       Close this window to stop the server.
  echo.
  call pnpm dev --open

  echo.
  echo The server has stopped.
  pause
  exit /b
)
