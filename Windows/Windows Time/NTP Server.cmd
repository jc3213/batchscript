@echo off
if [%1] equ [/r] goto :update
:main
echo ===========================================================
echo 1. China Time Server
echo 2. Ali
echo 3. Tencent
echo 4. Google
echo 5. Apple
echo 0. Synchronize Time Now
echo ===========================================================
set /p act=^> 
if [%act%] equ [1] set ntp=cn.ntp.org.cn
if [%act%] equ [2] set ntp=ntp.aliyun.com
if [%act%] equ [3] set ntp=ntp.tencent.com
if [%act%] equ [4] set ntp=time.google.com
if [%act%] equ [5] set ntp=time.apple.com
if [%act%] equ [0] goto :update
if not defined ntp cls && goto :main
echo.
echo.
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers" /ve /t "REG_SZ" /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers" /v "0" /t "REG_SZ" /d "%ntp%" /f
reg add "HKLM\SYSTEM\ControlSet001\Services\W32Time\Parameters" /v "NtpServer" /t "REG_SZ" /d "%ntp%,0x9" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\W32Time\Parameters" /v "NtpServer" /t "REG_SZ" /d "%ntp%,0x9" /f
echo.
echo.
:update
taskkill /f /im "explorer.exe"
echo.
echo.
net stop W32Time
echo.
echo.
net start W32Time
echo.
echo.
w32tm /resync
echo.
echo.
w32tm /resync
echo.
echo.
start "" "explorer.exe"
:exit
timeout /t 5

