@echo off
pushd %~dp0
for /f "tokens=1,2*" %%a in ('reg query HKLM\Software\7-Zip /V Path') do (if "%%a"=="Path" set Zip=%%c7z.exe)
"%Zip%" x %1 -y -x!$PLUGINSDIR -x!$R0 -x!uninstall.exe -o"%~dnp1"
type nul > "%~dnp1\portable_mode_enabled"
echo.
echo.
echo Portable location %~dnp1
echo.
echo.
timeout /t 5
