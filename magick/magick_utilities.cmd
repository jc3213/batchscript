@echo off
title ImageMagick Utilities
set imagick=%~dp0bin\magick.exe
:menu
cls
echo ============================================================
echo 1. Crop with area
echo 2. Cut off border
echo 3. Convert images
echo 4. Darken images
echo ============================================================
set /p op=^> 
if [%op%] equ [1] goto :crop
if [%op%] equ [2] goto :shave
if [%op%] equ [3] goto :format
if [%op%] equ [4] goto :darken
goto :menu
:crop
call :area
set name=cropped_
set params=-crop %area%
for %%a in (%*) do (call :process "%%~a" convert)
goto :exit
:shave
call :area
set name=cutted_
set params=-shave %area%
for %%a in (%*) do (call :process "%%~a" convert)
goto :exit
:format
call :output
set name=output%qu%_
set params=-quality %qu%
for %%a in (%*) do (call :process "%%~a")
goto :exit
:darken
call :level
set name=darken%lv%_
set params=-level %lv%%%,100%%
for %%a in (%*) do (call :process "%%~a")
goto :exit
:area
echo.
echo.
echo ============================================================
echo https://imagemagick.org/script/command-line-processing.php#geometry
echo Sample: 300x100 (width x height)
echo Cut left and right: 300px(width), cut top and bottom: 100px(height)
echo Sample: 300x100+20+30 (width x height + left + top)
echo Crop image area start from: left 20px to 320px, top 30px to 130px
echo ============================================================
set /p area=^> 
if not defined area goto :area
exit /b
:output
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
:quality
echo.
echo.
echo ============================================================
echo Set image quality: 1-100
echo Default: 90
echo ============================================================
set /p qu=^> 
echo %qu%| findstr /r "^[1-9]$ ^[1-9][0-9]$ ^100$" >nul || set qu=90
exit /b
:level
echo.
echo.
echo ============================================================
echo Set minimum color level: 0-100
echo Default: 30
echo ============================================================
set /p lv=^> 
echo %lv%| findstr /r "^[1-9]$ ^[1-9][0-9]$ ^100$" >nul || set lv=30
exit /b
:process
echo.
echo.
cd /d %1 2>nul
if %errorlevel% equ 0 goto :folder
call :imagick %1 %2
exit /b
:folder
set folder=%~dp1%name%%~nx1
md "%folder%" 2>nul
for %%a in (*) do (call :imagick "%%~a" %2)
set folder=
exit /b
:imagick
echo.
echo ImageMagick is processing: %1
if defined qu (set output=%~n1.%format%) else (set output=%~nx1)
if defined folder (set output=%folder%\%output%) else (set output=%~dp1%name%%output%)
if defined qu ("%imagick%" %2 %1 %params% "%~dp1%name%%~n1.%format%") else (%imagick%" %2 %1 %params% "%~dp1%name%%~nx1")
exit /b
:exit
timeout /t 5
