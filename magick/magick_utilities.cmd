@echo off
title ImageMagick Utilities
:menu
cls
echo ============================================================
echo 1. Crop with area
echo 2. Cut off border
echo 3. Trim empty area
echo 4. Convert format
echo 5. Darken images
echo 6. Resize images
echo ============================================================
set /p op=^> 
if [%op%] equ [1] goto :crop
if [%op%] equ [2] goto :shave
if [%op%] equ [3] goto :trim
if [%op%] equ [4] goto :format
if [%op%] equ [5] goto :darken
if [%op%] equ [6] goto :resize
goto :menu
:crop
call :area
set name=[cropped][%area%]
set params=-crop %area%
goto :main
:shave
call :area
set name=[cutted][%area%]
set params=-shave %area%
goto :main
:Trim
set name=[trimmed]
set params=-trim -define trim:edges=north,east,south,west -background white -fuzz 85%%
goto :main
:format
call :output
set name=[output][%format:~1%][%qu%]
set params=-quality %qu%
goto :main
:darken
call :level
set name=[darken][%lv%]
set params=-level %lv%%%,100%%
goto :main
:resize
call :size
call :output
set name=[resize][%size%][%qu%]
set params=-resize %size% -quality %qu%
goto :main
:area
echo.
echo.
echo ============================================================
echo https://imagemagick.org/script/command-line-processing.php#geometry
echo Sample: 300x (width)
echo Cut 300px from both left and right of the image
echo Sample: x400 (height)
echo Cut 400px from both top and bottom of the image
echo Sample: 300x100+20+30 (width x height + left + top)
echo Crop image area start from: left 20px to 320px, top 30px to 130px
echo Sample: 200x+50 (width + left)
echo Crop image area start from: left 50px to 250px, height 100%%
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
echo 4. webp
echo other. Original Format [Default]
echo ============================================================
set /p fm=^> 
if [%fm%] equ [1] set format=.jpg
if [%fm%] equ [2] set format=.png
if [%fm%] equ [3] set format=.avif
if [%fm%] equ [4] set format=.webp
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
:size
echo.
echo.
echo ============================================================
echo Sample: 300x100 (width x height)
echo Resize image to 300px width and 100px height
echo Sample: 500x (width)
echo Sample: x400 (height)
echo Resize image and keep aspect ratio
echo Sample: 50%%%%
echo Resize image to 50%% of its size
echo ============================================================
set /p size=^> 
if not defined size goto :size
echo.
echo.
echo ============================================================
echo 1. Lanczos Filter [Default]
echo 2. Lanczos2 Filter
echo 3. Hermite Filter
echo 4. Mitchell Filter *Recommended for enlarging*
echo 5. Hamming Filter
echo 6. Catrom Filter
echo 7. Gaussian Filter
echo ============================================================
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
:imagick
cd /d %1 2>nul
if %errorlevel% equ 0 goto :folder
if not defined format set format=%~x1
set output=%~dpn1 %name%%format%
call :appx %1
exit /b
:folder
set folder=%~1 %name%
md "%folder%" 2>nul
for %%a in (*) do (call :files "%%~a")
exit /b
:files
if not defined format set format=%~x1
set output=%folder%\%~n1%format%
:appx
echo.
echo.
echo Processing: %~dpnx1
"%~dp0bin\magick.exe" "%~1" %params% "%output%"
echo Output file: "%output%"
exit /b
:main
for %%a in (%*) do (call :imagick "%%~a")
timeout /t 5
