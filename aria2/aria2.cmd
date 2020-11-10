@ECHO OFF
PUSHD %~DP0
IF "%1"=="/h" CALL :RunHide
IF "%1"=="/n" CALL :Restart
IF "%1"=="/nh" CALL :Restart Hide
IF "%1"=="/s" CALL :Session
IF "%1"=="/sh" CALL :Session Hide
IF "%1"=="/r" CALL :Register
IF "%1"=="/rh" CALL :Register Hide
IF "%1"=="/u" CALL :Unregister
:Run
IF NOT EXIST "%CD%\aria2.session" (
    CALL :CleanSession
)
"%CD%\bin\aria2c.exe" --conf="%CD%\aria2.conf"
EXIT
:RunHide
IF NOT EXIST "%CD%\aria2.vbs" (
    ECHO CreateObject^("Wscript.Shell"^).Run """%CD%\aria2.cmd""", ^0>aria2.vbs
)
"%CD%\aria2.vbs"
EXIT
:Restart
CALL :Kill
CALL :Run%1
:Register
IF "%1" == "" (
    CALL :Registry \"%CD%\aria2.cmd\"
) ELSE (
    CALL :Registry \"%CD%\aria2.vbs\"
)
CALL :Kill
CALL :WebUI
CALL :Run%1
:Unregister
CALL :Kill
REG DELETE "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /V "Aria2" /F
EXIT
:Session
CALL :Kill
CALL :CleanSession
CALL :Run%1
:Kill
TASKKILL /F /IM "aria2c.exe" 2>nul
EXIT /B
:WebUI
START "" "https://ziahamza.github.io/webui-aria2/"
EXIT /B
:Registry
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /V "Aria2" /T "REG_SZ" /D "%1" /F
EXIT /B
:CleanSession
ECHO OFF>"%CD%\aria2.session"
EXIT /B
