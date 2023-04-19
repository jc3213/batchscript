@echo off
pushd %~dp0
for /f "tokens=1,2*" %%a in ('reg query "HKLM\Software\7-Zip" /V "Path"') do (if "%%a"=="Path" set Zip=%%c7z.exe)
echo ==================================================================
echo Remove original files or temporary files? (Y/y)
echo ==================================================================
set /p Yes=^> 
for %%a in (%*) do (call :Check %%a)
goto :Exit
:Check
cd /d %1 2>nul
if %ErrorLevel% equ 0 goto :NewPack
:Repack
echo a|"%Zip%" x %1 -o"%~dnp1"
"%Zip%" a "%~dnp1.zip" "%~dnp1\*"
if /i [%Yes%] neq [y] exit /b
rd /s /q "%~dnp1"
if /i %~X1 neq .zip del %1 /s /q
exit /b
:NewPack
"%Zip%" a "%~dnpx1.zip" "*"
if /i [%Yes%] neq [y] exit /b
cd..
rd /s /q "%~1"
exit /b
:Exit
timeout /t 5
