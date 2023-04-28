@echo off
title ImageMagick Utilities
set Magick=%~dp0bin\magick.exe
:Option
echo ============================================================
echo 1. Crop with area
echo 2. Cut off border
echo 3. Convert format
echo ============================================================
set /p Act=^> 
if [%Act%] equ [1] goto :Crop
if [%Act%] equ [2] goto :Shave
if [%Act%] equ [3] goto :Conv
cls && goto :Option
:Crop
call :Area
for %%a in (%*) do (call :Process %%a crop)
goto :Exit
:Shave
call :Area
for %%a in (%*) do (call :Process %%a shave)
goto :Exit
:Conv
call :Format
for %%a in (%*) do (call :Convert %%a)
goto :Exit
:Area
echo.
echo.
echo ============================================================
echo https://imagemagick.org/script/command-line-processing.php#geometry
echo Sample: 300x100 (width x height)
echo Cut left and right: 300px(width), cut top and bottom: 100px(height)
echo Sample: 300x100+20+30 (width x height + left + top)
echo Crop image area start from: left 20px to 320px, top: 30px to 130px
echo ============================================================
set /p Area=^> 
if not defined Area goto :Area
echo.
echo.
echo ImageMagick is processing images...
exit /b
:Process
cd /d %1 2>nul
if %ErrorLevel% equ 0 goto :ProcessFolder
"%Magick%" convert %1 -%2 %Area% "%~dp1cutted_%~nx1"
exit /b
:ProcessFolder
md "%~dp1cutted_%~nx1" 2>nul
for %%a in (*) do ("%Magick%" convert "%%a" -%2 %Area% "%~dp1cutted_%~nx1\%%a")
cd..
exit /b
:Format
echo.
echo.
echo ============================================================
echo 1. jpg
echo 2. png
echo 3. avif
echo ============================================================
set /p FM=^> 
if [%FM%] equ [1] set Format=jpg
if [%FM%] equ [2] set Format=png
if [%FM%] equ [3] set Format=avif
if not defined Format goto :Format
:Quality
echo.
echo.
echo ============================================================
echo Set image quality: 1-100
echo Default: 80
echo ============================================================
set /p QU=^> 
echo %QU%| findstr /r "^[1-9]$ ^[1-9][0-9]$ ^100$" >nul  || set QU=80
echo.
echo.
echo ImageMagick is converting images...
exit /b
:Convert
cd /d %1 2>nul
if %ErrorLevel% equ 0 goto :ConvertFolder
"%Magick%" %1 -quality %QU% "%~dp1conv_%~n1.%Format%"
exit /b
:ConvertFolder
md "%~dp1conv_%~nx1" 2>nul
for %%a in (*) do ("%Magick%" "%%a" -quality %QU% "%~dp1conv_%~nx1\%%~na.%Format%")
cd..
exit /b
:Exit
echo.
timeout /t 5
