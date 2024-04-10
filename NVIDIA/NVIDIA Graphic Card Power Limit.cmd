@echo off
net session >nul 2>nul && goto :runasadmin
mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c ""%~s0"" %*","","runas",1)(window.close)
exit
:runasadmin
title NVIDIA Graphic Card Power Limit Utility
for /f "tokens=1,3 delims=., " %%a in ('nvidia-smi --query-gpu=power.min_limit^,power.max_limit --format=csv^,noheader^,nounits ^|^| goto :error') do (call :powerlimit %%a %%b)
:powerlimit
cls
echo =======================================================================
echo Min Power Limit: %~1W
echo Max Power Limit: %~2W
echo =======================================================================
set /p pl=? 
echo %pl%| findstr /r /c:"^[1-9]$" /c:"^[1-9][0-9]$" /c:"^[1-9][0-9][0-9]$" >nul || goto :powerlimit
if %pl% lss %1 set pl=%1
if %pl% gtr %2 set pl=%2
echo.
echo The power limit has been set to "%pl%W" at current session
nvidia-smi -pl %pl%
:startup
echo.
echo.
echo =======================================================================
echo Keep Power Limit on Startup? (Y/y)
echo =======================================================================
set /p su=? 
if /i "%su%" neq "y" goto :exit
echo.
echo The power limit will be set to "%pl%W" on startup
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "NVIDIA Graphic Card Power Limit" /t "REG_SZ" /d "mshta vbscript:CreateObject(\"Shell.Application\").ShellExecute(\"nvidia-smi",\"-pl %pl%\",\"%windir%\System32",\"runas\",0)(window.close)" /f
goto :exit
:error
echo You don't have a NVIDIA graphic card installed in your system, or
echo The driver of your NVIDIA graphic card is not properly installed
:exit
timeout /t 5
exit
