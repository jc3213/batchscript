@echo off
net session >nul 2>&1 && goto :admin
mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c ""%~s0"" %*","%~dp0","runas",1)(window.close)
exit
:admin
if "%~1" equ "/r" goto :update
:main
cls
echo ===========================================================
echo 1. China Time Server
echo 2. Ali
echo 3. Tencent
echo 4. Google
echo 5. Apple
echo 0. Synchronize Time Now
echo ===========================================================
set /p act=^> 
if [%act%] equ [1] call :ntpserver "cn.ntp.org.cn"
if [%act%] equ [2] call :ntpserver "ntp.aliyun.com"
if [%act%] equ [3] call :ntpserver "ntp.tencent.com"
if [%act%] equ [4] call :ntpserver "time.google.com"
if [%act%] equ [5] call :ntpserver "time.apple.com"
if [%act%] equ [0] goto :update
goto :main
:ntpserver
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers" /ve /t "REG_SZ" /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers" /v "0" /t "REG_SZ" /d "%~1" /f
reg add "HKLM\SYSTEM\ControlSet001\Services\W32Time\Parameters" /v "NtpServer" /t "REG_SZ" /d "%~1,0x9" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\W32Time\Parameters" /v "NtpServer" /t "REG_SZ" /d "%~1,0x9" /f
:update
net start W32Time >nul 2>nul
:retry
for /f "tokens=4 delims=. " %%a in ('w32tm /resync') do (set done=%%a)
if [%done%] neq [successfully] goto :retry
taskkill /f /im "explorer.exe" >nul
start "" "explorer.exe"
timeout /t 5
