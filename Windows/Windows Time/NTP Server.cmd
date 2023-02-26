@ECHO OFF
IF %1 EQU /r GOTO :Sync
ECHO ===========================================================
ECHO 1. China Time Server
ECHO 2. Ali
ECHO 3. Tencent
ECHO 4. Google
ECHO 5. Apple
ECHO 0. Synchronize Time Now
ECHO ===========================================================
:Select
SET /P NTP=^> 
IF %NTP% EQU 1 SET Server=cn.ntp.org.cn
IF %NTP% EQU 2 SET Server=ntp.aliyun.com
IF %NTP% EQU 3 SET Server=ntp.tencent.com
IF %NTP% EQU 4 SET Server=time.google.com
IF %NTP% EQU 5 SET Server=time.apple.com
IF %NTP% EQU 0 GOTO :Sync
IF NOT DEFINED Server GOTO :Select
ECHO.
ECHO.
:Time
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers" /VE /T "REG_SZ" /D "0" /F
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers" /V "0" /T "REG_SZ" /D "%Server%" /F
REG ADD "HKLM\SYSTEM\ControlSet001\Services\W32Time\Parameters" /V "NtpServer" /T "REG_SZ" /D "%Server%,0x9" /F
REG ADD "HKLM\SYSTEM\CurrentControlSet\Services\W32Time\Parameters" /V "NtpServer" /T "REG_SZ" /D "%Server%,0x9" /F
:Sync
TASKKILL /F /IM "explorer.exe"
ECHO.
ECHO.
NET STOP W32TIME
ECHO.
ECHO.
NET START W32TIME
ECHO.
ECHO.
W32TM /resync
ECHO.
ECHO.
W32TM /resync
ECHO.
ECHO.
START "" "explorer.exe"
:Exit
TIMEOUT /T 5
EXIT
