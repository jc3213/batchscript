@echo off
title Images Upscale Utilities
:main
cls
echo ============================================================
echo 1. Real-ESRGAN Plus
echo 2. Real-ESRGAN Plus Anime
echo 3. Real-ESRGAN Anime Video v3
echo 4. Waifu2x CUnet
echo 5. Waifu2x Up-convert RGB
echo 6. Waifu2x Up-convert Photo
echo ============================================================
set /p md=^> 
if [%md%] equ [1] goto :plusx4
if [%md%] equ [2] goto :x4anime
if [%md%] equ [3] goto :videoanime
if [%md%] equ [4] goto :cunet
if [%md%] equ [5] goto :uprgb
if [%md%] equ [6] goto :upphoto
goto :main
:plusx4
set app=realesrgan
set model=realesrgan-x4plus
set name=(Real-EARGAN)(x4plus)(4x)
set scale=4
set params=-n %model%
goto :format
:x4anime
set app=realesrgan
set model=realesrgan-x4plus-anime
set name=(Real-EARGAN)(x4plus-anime)(4x)
set scale=4
set params=-n %model%
goto :format
:videoanime
set app=realesrgan
set model=realesr-animevideov3
set name=(Real-EARGAN)(animevideov3)
set params=-n %model%
call :scale
goto :format
:cunet
set app=waifu2x
set model=cunet
set name=(Waifu2x)(cunet)
set params=-m models-%model%
call :scale
goto :noise
:uprgb
set app=waifu2x
set model=upconv_7_anime_style_art_rgb
set name=(Waifu2x)(upconv_7_anime_style_art_rgb)
set params=-m models-%model%
call :scale
goto :noise
:upphoto
set app=waifu2x
set model=upconv_7_photo
set name=(Waifu2x)(upconv_7_photo)
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
echo Denoise Level: 0-3
echo Default: 0 (Disabled)
echo ============================================================
set /p noise=^> 
echo %noise%| findstr /r "^[0-3]$" >nul || set noise=0
set name=%name%(lv%noise%)
set params=%params% -n %noise%
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
:upscale
cls
echo ============================================================
for /f "delims=()" %%a in ("%name%") do (set worker=%%a)
echo Upscaler     :   %worker%
echo Model        :   %model%
echo Scale Ratio  :   %scale%x
if defined noise echo Denoise      :   Lv.%noise%
if [%tta%] equ [1] echo TTA Mode     :   Enabled
echo ============================================================
for %%a in (%*) do (call :worker "%%~a")
timeout /t 5
exit
:worker
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
