@echo off
if [%1] equ [/r] goto :Sync
echo ===========================================================
echo 1. China Time Server
echo 2. Ali
echo 3. Tencent
echo 4. Google
echo 5. Apple
echo 0. Synchronize Time Now
echo ===========================================================
:Select
set /p NTP=^> 
if [%NTP%] equ [1] call :Server "cn.ntp.org.cn"
if [%NTP%] equ [2] call :Server "ntp.aliyun.com"
if [%NTP%] equ [3] call :Server "ntp.tencent.com"
if [%NTP%] equ [4] call :Server "time.google.com"
if [%NTP%] equ [5] call :Server "time.apple.com"
if [%NTP%] equ [0] goto :Sync
goto :Select
:Server
echo.
echo.
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers" /ve /t "REG_SZ" /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers" /v "0" /t "REG_SZ" /d "%~1" /f
reg add "HKLM\SYSTEM\ControlSet001\Services\W32Time\Parameters" /v "NtpServer" /t "REG_SZ" /d "%~1,0x9" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\W32Time\Parameters" /v "NtpServer" /t "REG_SZ" /d "%~1,0x9" /f
echo.
echo.
:Sync
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
:Exit
timeout /t 5
exit
