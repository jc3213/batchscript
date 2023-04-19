@echo off
pushd %~dp0
if exist %1 goto :Unpack
:File
set /p File=Select .MSI Installer: 
if not exist "%File%" goto :File
call :Unpack "%File%"
:Unpack
msiexec /a "%1" /q targetdir=%~DP1_unpacked
echo.
echo.
timeout /t 5
exit
