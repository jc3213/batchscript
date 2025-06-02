@echo off
setlocal enabledelayedexpansion
title ImageMagick Utilities
:menu
cls
echo ===================================================================
echo 1. Crop with area
echo 2. Cut off border
echo 3. Convert format
echo 4. Resize images
echo 5. Darken images
echo ===================================================================
set /p op=^> 
if [%op%] equ [1] goto :crop
if [%op%] equ [2] goto :shave
if [%op%] equ [3] goto :format
if [%op%] equ [4] goto :resize
if [%op%] equ [5] goto :darken
goto :menu
:crop
call :area
set name=[crop][%area%]
set params=-crop %area%
goto :main
:shave
call :area
set name=[cut][%area%]
set params=-shave %area%
goto :main
:format
call :convert
set name=[convert][%format:~1%][%qu%]
set params=-quality %qu%
goto :main
:resize
call :size
call :convert
set name=[resize][%size%][%qu%]
set params=-resize %size% -quality %qu%
goto :main
:darken
call :level
set name=[darken][%lv%]
set params=-level %lv%%%,100%%
goto :main
:area
echo.
echo.
echo ===================================================================
echo https://imagemagick.org/script/command-line-processing.php#geometry
echo Sample: 300x (width)
echo Cut 300px from both left and right of the image
echo Sample: x400 (height)
echo Cut 400px from both top and bottom of the image
echo Sample: 300x100+20+30 (width x height + left + top)
echo Crop image area start from: left 20px to 320px, top 30px to 130px
echo Sample: 200x+50 (width + left)
echo Crop image area start from: left 50px to 250px, height 100%%
echo ===================================================================
set /p area=^> 
if not defined area goto :area
exit /b
:convert
echo.
echo.
echo ===================================================================
echo 1. jpg
echo 2. png [Default]
echo 3. avif
echo 4. webp
echo ===================================================================
set /p fm=^> 
if [%fm%] equ [1] set format=.jpg
if [%fm%] equ [3] set format=.avif
if [%fm%] equ [4] set format=.webp
if not defined format set format=.png
:quality
echo.
echo.
echo ===================================================================
echo Set image quality: 1-100
echo Default: 90
echo ===================================================================
set /p qu=^> 
echo %qu%| findstr /r "^[1-9]$ ^[1-9][0-9]$ ^100$" >nul || set qu=90
exit /b
:level
echo.
echo.
echo ===================================================================
echo Set minimum color level: 0-100
echo Default: 30
echo ===================================================================
set /p lv=^> 
echo %lv%| findstr /r "^[1-9]$ ^[1-9][0-9]$ ^100$" >nul || set lv=30
exit /b
:size
echo.
echo.
echo ===================================================================
echo Sample: 300x100 (width x height)
echo Resize image to 300px width and 100px height
echo Sample: 500x (width)
echo Sample: x400 (height)
echo Resize image and keep aspect ratio
echo Sample: 50%%%%
echo Resize image to 50%% of its size
echo ===================================================================
set /p size=^> 
if not defined size goto :size
echo.
echo.
echo ===================================================================
echo 1. Lanczos Filter [Default]
echo 2. Lanczos2 Filter
echo 3. Hermite Filter
echo 4. Mitchell Filter *Recommended for enlarging*
echo 5. Hamming Filter
echo 6. Catrom Filter
echo 7. Gaussian Filter
echo ===================================================================
set /p ft=^> 
if [%ft%] equ [2] set filter=Lanczos2
if [%ft%] equ [3] set filter=Hermite
if [%ft%] equ [4] set filter=Mitchell
if [%ft%] equ [5] set filter=Hamming
if [%ft%] equ [6] set filter=Catrom
if [%ft%] equ [7] set filter=Gaussian
if defined ft set filter=Lanczos
set params=%params% -filter %filter%
exit /b
:main
set start=%time%
for %%a in (%*) do (call :imagick "%%~a")
set finish=%time%
set /a stsec=%start:~0,2%*360000+%start:~3,2%*6000+%start:~6,2%*100+%start:~9,2%
set /a finsec=%finish:~0,2%*360000+%finish:~3,2%*6000+%finish:~6,2%*100+%finish:~9,2%
if %finsec% lss %stsec% set /a finsec+=8640000
set /a elapsed=%finsec%-%stsec%
set /a hour=elapsed/360000
set /a minute=(elapsed%%360000)/6000
set /a second=(elapsed%%6000)/100
set /a millsec=elapsed%%100
if %hour% lss 10 set hour=0%hour%
if %minute% lss 10 set minute=0%minute%
if %second% lss 10 set second=0%second%
if %millsec% lss 10 set millsec=0%millsec%
echo Elapsed    : %hour%:%minute%:%second%.%millsec%
endlocal
pause
exit
:imagick
set folder=%~dp1
cd /d %1 2>nul
if %errorlevel% equ 0 goto :folder
if not defined format set format=%~x1
set output= %name%
goto :output
:folder
set folder=%folder%%~nx1 %name%\
md "%folder%" 2>nul
for %%a in (*) do (call :output "%%~a")
exit /b
:output
echo.
echo.
echo Processing : "%~dpnx1"
if not defined format set format=%~x1
"%~dp0bin\magick.exe" "%~1" %params% "%folder%%~n1%output%%format%" >nul 2>nul
echo Result     : "%folder%%~n1%output%%format%"
exit /b
