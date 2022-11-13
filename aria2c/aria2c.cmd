@ECHO OFF
PUSHD %~DP0
IF "%1"=="/h" CALL :Run 0
IF "%1"=="/s" CALL :Session
IF "%1"=="/sh" CALL :Session 0
IF "%1"=="/r" CALL :Startup
IF "%1"=="/rh" CALL :Startup 0
IF "%1"=="/u" CALL :Unregister
GOTO :Run
:Startup
IF "%1"=="0" (SET App=vbs) ELSE (SET App=cmd)
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /V "aria2c" /T "REG_SZ" /D "%CD%\aria2c.%App%" /F
START "" "https://ziahamza.github.io/webui-aria2/"
:Run
IF "%1"=="0" (
    IF NOT EXIST aria2c.vbs (
        ECHO Set Sh=CreateObject^("WScript.Shell"^)>aria2c.vbs
        ECHO Sh.Run Sh.CurrentDirectory ^& "\aria2c.cmd", ^0>>aria2c.vbs
    )
    aria2c.vbs
) ELSE (bin\aria2c.exe --conf=aria2c.conf)
EXIT
:Session
ECHO OFF>aria2c.session"
GOTO :Run
:Unregister
REG DELETE "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /V "aria2c" /F
TIMEOUT -T 5
