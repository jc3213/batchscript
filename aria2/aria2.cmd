@ECHO OFF
PUSHD %~DP0
IF "%1"=="/h" CALL :Run 0
IF "%1"=="/s" CALL :Session
IF "%1"=="/sh" CALL :Session 0
IF "%1"=="/r" CALL :Startup
IF "%1"=="/rh" CALL :Startup 0
IF "%1"=="/u" CALL :Unregister
CALL :Run
:Session
ECHO OFF>aria2.session"
GOTO :Run
:Startup
IF "%1"=="0" (SET App=vbs) ELSE (SET App=cmd)
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /V "Aria2" /T "REG_SZ" /D "%CD%\aria2.%App%" /F
GOTO :Run
:Run
TASKKILL /F /IM "aria2c.exe" 1>NUL 2>NUL
IF "%1"=="0" (
    IF NOT EXIST aria2.vbs (ECHO CreateObject^("Wscript.Shell"^).Run """%CD%\bin\aria2c.exe"" --conf=""%CD%\aria2.conf""", ^0>aria2.vbs)
    aria2.vbs
) ELSE (bin\aria2c.exe --conf=aria2.conf)
START "" "https://ziahamza.github.io/webui-aria2/"
EXIT
:Unregister
REG DELETE "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /V "Aria2" /F
TIMEOUT -T 5
