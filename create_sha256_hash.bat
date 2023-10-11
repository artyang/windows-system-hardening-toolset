@echo off
setlocal enabledelayedexpansion

rem Check if a file is specified
if "%~1"=="" (
  echo Usage: %~nx0 filename
  exit /b 1
)

rem Check if the file exists
if not exist "%~1" (
  echo File not found: %~1
  exit /b 1
)

rem Calculate SHA-256 hash
set "filename=%~1"
for /f %%H in ('CertUtil -hashfile "%filename%" SHA256 ^| find /v ":"') do (
  set "hash=%%H"
  echo SHA-256 hash of %filename% is: !hash!
)

endlocal
