@echo off
pushd %~dp0
if [%1] equ [/h] goto :NoWindow
if [%1] equ [/r] goto :Register
if [%1] equ [/u] goto :Unregister
if not exist aria2c.session type nul > aria2c.session
bin\aria2c.exe --conf=aria2c.conf
:Register
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "aria2c" /t "REG_SZ" /d "%CD%\aria2c.vbs" /f
:NoWindow
if not exist aria2c.session type nul > aria2c.session
if not exist aria2c.vbs call :VBS
aria2c.vbs
exit
:VBS
echo Set objSh = CreateObject("WScript.Shell")>aria2c.vbs
echo Set objFSO = CreateObject("Scripting.FileSystemObject")>>aria2c.vbs
echo Set objFile = objFSO.GetFile(Wscript.ScriptFullName)>>aria2c.vbs
echo objDir = objFSO.GetParentFolderName(objFile)>>aria2c.vbs
echo objSh.run "%WinDir%\System32\cmd.exe /k pushd " ^& objDir ^& " && bin\aria2c.exe --conf=aria2c.conf", ^0>>aria2c.vbs
exit /b
:Unregister
taskkill /im "aria2c.exe"
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "aria2c" /f
timeout /t 5

