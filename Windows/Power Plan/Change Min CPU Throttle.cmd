@echo off
set /p min=^> 
echo %min%| findstr /r /c:"^[0-9]$" /c:"^[1-9][0-9]$" /c:"^100$" >nul
if %errorlevel% equ 1 set min=0
powercfg /setacvalueindex scheme_current sub_processor PROCTHROTTLEMAX %min%
powercfg /setactive scheme_current
timeout /t 5
