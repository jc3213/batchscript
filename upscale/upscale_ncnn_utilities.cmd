@echo off
title Image Upscale Utilities
:menu
cls
echo ============================================================
echo 1. Real-ESRGAN Plus Anime
echo 2. Real-ESRGAN Anime Video v3
echo 3. Real-CUGAN Se
echo 4. Real-CUGAN Pro
echo 5. Waifu2x CUnet
echo 6. Waifu2x Anime Style
echo ============================================================
set /p md=^> 
if [%md%] equ [1] goto :x4anime
if [%md%] equ [2] goto :videoanime
if [%md%] equ [3] goto :cuganse
if [%md%] equ [4] goto :cuganpro
if [%md%] equ [5] goto :cunet
if [%md%] equ [6] goto :style
goto :menu
:x4anime
set app=realesrgan
set worker=Real-ESRGAN
set model=x4plus-anime
set name=(%app%)(x4plus-anime)(4x)
set scale=4
set params=-n %app%-%model%
goto :tile
:videoanime
set app=realesrgan
set worker=Real-ESRGAN
set model=animevideov3
set name=(%app%)(animevideov3)
set params=-n realesr-%model%
call :scale
goto :tile
:cuganse
set app=realcugan
set worker=Real-CUGAN
set model=se
set name=(%app%)(se)
set params=-m models-%model%
call :scale
goto :noise
:cuganpro
set app=realcugan
set worker=Real-CUGAN
set model=pro
set name=(%app%)(pro)(2x)
set scale=2
set params=-m models-%model%
goto :noise
:cunet
set app=waifu2x
set worker=Waifu2x
set model=cunet
set name=(%app%)(cunet)
set params=-m models-%model%
call :scale
goto :noise
:style
set app=waifu2x
set worker=Waifu2x
set model=upconv_7_anime_style_art_rgb
set name=(%app%)(upconv_7_anime_style_art_rgb)
set params=-m models-%model%
call :scale
goto :noise
:scale
echo.
echo.
echo ============================================================
echo 1. Scale 2x [Default]
echo 2. Scale 4x
echo ============================================================
set /p sc=^> 
if [%sc%] equ [2] set scale=4
if not defined scale set scale=2
set name=%name%(%scale%x)
set params=%params% -s %scale%
exit /b
:noise
echo.
echo.
echo ============================================================
echo Denoise Level: -1 ~ 3
echo Default: 0
echo ============================================================
set /p noise=^> 
echo %noise%| findstr /r "^[0-3]$ ^-1$" >nul || set noise=0
set name=%name%(lv%noise%)
set params=%params% -n %noise%
:tile
echo.
echo.
echo ============================================================
echo Split Tiles: 0 ~ 144
echo Default: 0 (Auto)
echo ============================================================
set /p tile=^> 
echo %tile%| findstr /r "^[0-9]$ ^[1-9][0-9]$ ^1[0-3][0-9]$ ^14[1-4]$" >nul || set tile=0
set params=%params% -t %tile%
:tta
echo.
echo.
echo ============================================================
echo 1. Enable TTA Mode
echo ============================================================
set /p tta=^> 
if [%tta%] neq [1] goto :format
set name=%name%(TTA)
set params=%params% -x
:format
echo.
echo.
echo ============================================================
echo 1. jpg
echo 2. png [Default]
echo 3. webp
echo ============================================================
set /p fm=^> 
if [%fm%] equ [1] set format=jpg
if [%fm%] equ [3] set format=webp
if not defined format set format=png
:main
cls
echo ============================================================
echo Upscaler   :   %worker%
echo Model      :   %model%
echo Scale      :   %scale%x
echo Tiles      :   %tile%
if defined noise echo Denoise    :   Lv.%noise%
if [%tta%] equ [1] echo TTA Mode   :   Enabled
echo ============================================================
for %%a in (%*) do (call :upscale "%%~a")
timeout /t 5
exit
:upscale
cd /d %1 2>nul
if %errorlevel% equ 0 goto :folder
set output=%~dpn1 %name%.%format%
goto :appx
:folder
set folder=%~1 %name%
md "%folder%" 2>nul
for %%a in (*) do (call :files "%%~a")
exit /b
:files
set output=%folder%\%~n1.%format%
:appx
echo.
echo.
echo Processing : "%~dpnx1"
"%~dp0bin\%app%-ncnn-vulkan.exe" -i "%~1" -o "%output%" %params% >nul 2>nul
echo Output     : "%output%"
exit /b
