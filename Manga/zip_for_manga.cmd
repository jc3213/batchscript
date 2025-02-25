@echo off
pushd %~dp0
for /f "tokens=2*" %%a in ('reg query "HKLM\Software\7-Zip" /v "Path"') do (set zip=%%b7z.exe)
echo =====================================================================
echo Remove original files or temporary files?
echo Press "Enter" key to keep them.
echo =====================================================================
set /p yes=^> 
for %%a in (%*) do (call :main %%a)
goto :exit
:main
echo.
echo 7-Zip is processing "%~nx1"
cd /d %1 2>nul
if %errorlevel% equ 0 goto :newzip
:repack
"%zip%" x %1 -o"%~dnp1" -aoa >nul
"%zip%" a "%~dnp1.zip" "%~dnp1\*" >nul
if not defined yes exit /b
rd /s /q "%~dnp1"
if /i %~x1 neq .zip del %1 /s /q
exit /b
:newzip
"%zip%" a "%~dnpx1.zip" "*" >nul
if not defined yes exit /b
cd..
rd /s /q "%~1"
exit /b
:exit
timeout /t 5
