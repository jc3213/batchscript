@ECHO OFF
PUSHD %~DP0
IF "%1"=="/h" GOTO :Hide
IF "%1"=="/r" GOTO :Register
IF "%1"=="/u" GOTO :Unregister
:App
IF NOT EXIST aria2c.session CALL :Session
bin\aria2c.exe --conf=aria2c.conf
EXIT
:Hide
IF NOT EXIST aria2c.session CALL :Session
IF NOT EXIST aria2.vbs CALL :Startup
aria2c.vbs
EXIT
:Register
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /V "aria2c" /T "REG_SZ" /D "%CD%\aria2c.vbs" /F
CALL :Session
CALL :Startup
aria2c.vbs
EXIT
:Unregister
TASKKILL /IM "aria2c.exe"
REG DELETE "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /V "aria2c" /F
TIMEOUT -T 5
EXIT
:Session
ECHO OFF>aria2c.session
EXIT /B
:Startup
ECHO Set objSh = CreateObject("WScript.Shell")>aria2c.vbs
ECHO Set objFSO = CreateObject("Scripting.FileSystemObject")>>aria2c.vbs
ECHO Set objFile = objFSO.GetFile(Wscript.ScriptFullName)>>aria2c.vbs
ECHO objDir = objFSO.GetParentFolderName(objFile)>>aria2c.vbs
ECHO objSh.run """" ^& objDir ^& "\bin\aria2c.exe"" --conf=""" ^& objDir ^& "\aria2c.conf""", ^0>>aria2c.vbs
EXIT /B
