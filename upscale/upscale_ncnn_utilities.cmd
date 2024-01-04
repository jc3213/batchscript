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
set app=realesrgan-ncnn-vulkan.exe
set model=realesrgan-x4plus
set name=(Real-EARGAN)(x4plus)(4x)
set scale=4
goto :format
:x4anime
set app=realesrgan-ncnn-vulkan.exe
set model=realesrgan-x4plus-anime
set name=(Real-EARGAN)(x4plus-anime)(4x)
set scale=4
goto :format
:videoanime
set app=realesrgan-ncnn-vulkan.exe
set model=realesr-animevideov3
set name=(Real-EARGAN)(animevideov3)
call :scale
goto :format
:cunet
set app=waifu2x-ncnn-vulkan.exe
set model=models-cunet
set name=(Waifu2x)(cunet)
call :scale
goto :noise
:uprbg
set app=waifu2x-ncnn-vulkan.exe
set model=models-upconv_7_anime_style_art_rgb
set name=(Waifu2x)(upconv_7_anime_style_art_rgb)
call :scale
goto :noise
:upphoto
set app=waifu2x-ncnn-vulkan.exe
set model=models-upconv_7_photo
set name=(Waifu2x)(upconv_7_photo)
call :scale
goto :noise
:scale
echo.
echo.
echo ============================================================
echo 1. Scale 2x
echo 2. Scale 4x
echo ============================================================
set /p sc=^> 
if [%sc%] equ [1] set scale=2
if [%sc%] equ [2] set scale=4
if not defined scale goto :scale
set name=%name%(%scale%x)
set params=-s %scale%
exit /b
noise
echo.
echo.
echo ============================================================
echo 0. Disable Denoise
echo 1. Denoise Level 1
echo 2. Denoise Level 2
echo 3. Denoise Level 3
echo ============================================================
set /p no=^> 
if [%no%] equ [0] set noise=0
if [%no%] equ [1] set noise=1
if [%no%] equ [2] set noise=2
if [%no%] equ [3] set noise=3
if not defined noise goto :noise
set params=%params% -n %noise%
set name=%name%(lv%noise%)
:tta
echo.
echo.
echo ============================================================
echo 1. Enable TTA Mode
echo ============================================================
set /p tta=^> 
if [%tta%] neq [1] goto :format
set params=%params% -x
set name=%name%(TTA)
:format
echo.
echo.
echo ============================================================
echo 1. jpg
echo 2. png
echo 3. webp
echo ============================================================
set /p fm=^> 
if [%fm%] equ [1] set format=jpg
if [%fm%] equ [2] set format=png
if [%fm%] equ [3] set format=webp
if not defined format goto :format
:upscale
echo.
echo.
for /F "delims=()" %%a in ("%name%") do (set worker=%%a)
echo %worker% is processing with model: "%model%"
echo Multiplier : %scale%x
if defined noise echo Denoise    : Lv.%noise%
if [%tta%] equ [1] echo TTA Mode   : Enabled
echo.
for %%a in (%*) do (call :worker "%%~a")
timeout /t 5
exit
:worker
cd /d %1 2>nul
if %errorlevel% equ 0 goto :folder
echo.
echo Processing : "%~1"
"%~dp0bin\%app%" -i %1 -o "%~dpn1 %name%.%format%" -n %model% %params% 1>nul 2>&1
echo Output     : "%~dpn1 %name%.%format%"
exit /b
:folder
set folder=%~1 %name%
md "%folder%" 2>nul
for %%a in (*) do (call :files "%%~a")
exit /b
:files
echo.
echo Processing : "%~dpnx1"
"%~dp0bin\%app%" -i "%~dpnx1" -o "%folder%\%~n1.%format%" -n %model% %params% 1>nul 2>&1
echo Output     : "%folder%\%~n1.%format%"
exit /b
