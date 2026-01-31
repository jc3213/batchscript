@echo off
setlocal
pushd %~dp0
for /f "usebackq tokens=2 delims=:}" %%a in (`curl -s "https://bellard.org/quickjs/binary_releases/LATEST.json"`) do (set version=%%a)
set version=%version:"=%
set file=quickjs-win-x86_64-%version%.zip
curl -L -o "%file%" "https://bellard.org/quickjs/binary_releases/%file%"
powershell -command "Expand-Archive -Force '%file%' '.'"
endlocal
timeout /t 5
