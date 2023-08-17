@echo off
setlocal enabledelayedexpansion
set /a li=0
set /a act=9
for /f "tokens=2*" %%a in ('reg query "HKCU\Software\Microsoft\OneDrive" /v UserFolder 2^>nul') do (call :trim "%%b" "Microsoft OneDrive")
for /f "tokens=2*" %%a in ('reg query "HKEY_CURRENT_USER\Software\Google\DriveFS" /v SharePath 2^>nul') do (call :trim "%%b" "Google Drive")
for /f "tokens=2*" %%a in ('reg query "HKCU\Software\Mega Limited\MEGAsync\Syncs" /v 0 2^>nul') do (call :trim "%%b" "MEGA Cloud Storage")
for /f "tokens=2*" %%a in ('reg query "HKCU\Software\baidu\BaiduYunGuanjia" /v SyncPath 2^>nul') do (call :trim "%%b" "Baidu YunDisk")
if %li% equ 0 goto :error
:main
cls
echo ====================================================================================================

echo ====================================================================================================
pause
set /p act=^> 
if %act% gtr %li% goto :main


:trim
if not exist "%~1" exit /b
set /a li+=1
set menu%li%=%1
set show%li%=%2
exit /b
:menu

exit /b
:error
echo No cloud sync service founded! Exit in 5 seconds...
:exit
timeout /t 5
