@echo off
title ImageMagick Utilities
set imagick=%~dp0bin\magick.exe
:Main
echo ============================================================
echo 1. Crop with area
echo 2. Cut off border
echo 3. Convert images
echo ============================================================
set /p act=^> 
if [%act%] equ [1] goto :Crop
if [%act%] equ [2] goto :Shave
if [%act%] equ [3] goto :Conv
cls && goto :Main
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
set /p area=^> 
if not defined area goto :Area
echo.
echo.
echo ImageMagick is processing images...
exit /b
:Process
cd /d %1 2>nul
if %errorlevel% equ 0 goto :ProcessFolder
"%imagick%" convert %1 -%2 %area% "%~dp1cutted_%~nx1"
exit /b
:ProcessFolder
md "%~dp1cutted_%~nx1" 2>nul
for %%a in (*) do ("%imagick%" convert "%%a" -%2 %area% "%~dp1cutted_%~nx1\%%a")
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
set /p fm=^> 
if [%fm%] equ [1] set format=jpg
if [%fm%] equ [2] set format=png
if [%fm%] equ [3] set format=avif
if not defined format goto :Format
:Quality
echo.
echo.
echo ============================================================
echo Set image quality: 1-100
echo Default: 90
echo ============================================================
set /p qu=^> 
echo %qu%| findstr /r "^[1-9]$ ^[1-9][0-9]$ ^100$" >nul || set qu=90
echo.
echo.
echo ImageMagick is converting images...
exit /b
:Convert
cd /d %1 2>nul
if %errorlevel% equ 0 goto :ConvertFolder
"%imagick%" %1 -quality %qu% "%~dp1conv_%~n1.%format%"
exit /b
:ConvertFolder
md "%~dp1conv_%~nx1" 2>nul
for %%a in (*) do ("%imagick%" "%%a" -quality %qu% "%~dp1conv_%~nx1\%%~na.%format%")
cd..
exit /b
:Exit
echo.
timeout /t 5
