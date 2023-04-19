@echo off
pushd %~dp0
if [%1] equ [/h] goto :Hide
if [%1] equ [/r] goto :Register
if [%1] equ [/u] goto :Unregister
:App
if not exist aria2c.session call :Session
bin\aria2c.exe --conf=aria2c.conf
exit
:Hide
if not exist aria2c.session call :Session
if not exist aria2c.vbs call :Startup
aria2c.vbs
exit
:Register
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "aria2c" /t "REG_SZ" /d "%CD%\aria2c.vbs" /f
goto :Hide
:Unregister
taskkill /im "aria2c.exe"
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "aria2c" /f
timeout /t 5
exit
:Session
type nul>aria2c.session
exit /b
:Startup
echo Set objSh = CreateObject("WScript.Shell")>aria2c.vbs
echo Set objFSO = CreateObject("Scripting.FileSystemObject")>>aria2c.vbs
echo Set objFile = objFSO.GetFile(Wscript.ScriptFullName)>>aria2c.vbs
echo objDir = objFSO.GetParentFolderName(objFile)>>aria2c.vbs
echo objSh.run "%WinDir%\System32\cmd.exe /k pushd " ^& objDir ^& " && bin\aria2c.exe --conf=aria2c.conf", ^0>>aria2c.vbs
exit /b
