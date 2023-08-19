@echo off
set /p max=^> 
echo %max%| findstr /r /c:"^[5-9][0-9]$" /c:"^100$" >nul
if %errorlevel% equ 1 set max=100
powercfg /setacvalueindex scheme_current sub_processor PROCTHROTTLEMAX %max%
powercfg /setactive scheme_current
timeout /t 5
