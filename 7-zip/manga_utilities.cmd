@echo off
pushd %~dp0
for /f "tokens=2*" %%a in ('reg query "HKLM\Software\7-Zip" /v "Path"') do (set zip=%%b7z.exe)
echo ==================================================================
echo Remove original files or temporary files? (Y/y)
echo ==================================================================
set /p yes=^> 
for %%a in (%*) do (call :main %%a)
goto :exit
:main
cd /d %1 2>nul
if %ErrorLevel% equ 0 goto :newzip
:repack
echo a|"%zip%" x %1 -o"%~dnp1"
"%zip%" a "%~dnp1.zip" "%~dnp1\*"
if /i [%yes%] neq [y] exit /b
rd /s /q "%~dnp1"
if /i %~X1 neq .zip del %1 /s /q
exit /b
:newzip
"%zip%" a "%~dnpx1.zip" "*"
if /i [%yes%] neq [y] exit /b
cd..
rd /s /q "%~1"
exit /b
:exit
timeout /t 5
