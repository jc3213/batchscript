@echo off
pushd %~dp0
for /f "tokens=2*" %%a in ('reg query "HKLM\Software\7-Zip" /v "Path"') do (set zip=%%b7z.exe)
"%zip%" x %1 -y -x!$PLUGINSDIR -x!$R0 -x!uninstall.exe -o"%~dnp1"
type nul > "%~dnp1\portable_mode_enabled"
echo.
echo.
echo Portable location %~dnp1
echo.
echo.
timeout /t 5
