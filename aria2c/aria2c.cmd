@echo off
setlocal enabledelayedexpansion
pushd %~dp0
for /f "delims=" %%a in ('dir /s /b aria2c.exe') do (set aria2c=%%a)
set aria2c=!aria2c:%~dp0=!
if not exist aria2c.session type nul > aria2c.session
if [%1] equ [/s] goto :nowindow
if [%1] equ [/r] goto :register
if [%1] equ [/u] goto :Unregister
"%aria2c%" --conf=aria2c.conf
:register
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "aria2c" /t "REG_SZ" /d "mshta vbscript:CreateObject(\"Shell.Application\").ShellExecute(\"%aria2c%\",\"--conf=aria2c.conf\",\"%~dp0",\"\",0)(window.close)" /f
:nowindow
mshta vbscript:CreateObject("Shell.Application").ShellExecute("bin\aria2c.exe","--conf=aria2c.conf","%~dp0","",0)(window.close)
exit
:unregister
taskkill /im "aria2c.exe"
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "aria2c" /f
timeout /t 5
