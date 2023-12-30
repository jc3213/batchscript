@echo off
title Waifu2x Utilities
set waifu2x=%~dp0bin\waifu2x-ncnn-vulkan.exe
:main
cls
echo ============================================================
echo 1. Waifu2x CUnet
echo 2. Waifu2x Up-convert RGB
echo 3. Waifu2x Up-convert Photo
echo ============================================================
set /p md=^> 
if [%md%] equ [1] goto :cunet
if [%md%] equ [2] goto :uprgb
if [%md%] equ [3] goto :upphoto
goto :main
:cunet
set model=models-cunet
set name=cunet
goto :scale
:uprgb
set model=models-upconv_7_anime_style_art_rgb
set name=upconv_7_anime_style_art_rgb
goto :scale
:upphoto
set model=models-upconv_7_photo
set name=upconv_7_photo
:scale
echo.
echo.
echo ============================================================
echo 1. Scale x2
echo 2. Scale x4
echo 3. Scale x8
echo ============================================================
set /p sc=^> 
if [%sc%] equ [1] set scale=2
if [%sc%] equ [2] set scale=4
if [%sc%] equ [3] set scale=8
if defined scale goto :noise
goto :scale
:noise
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
if defined noise goto :tta
goto :noise
:tta
echo.
echo.
echo ============================================================
echo 1. Enable TTA Mode
echo ============================================================
set /p tm=^> 
set enable=Disabled
if [%tm%] neq [1] goto :format
set tta=-x
set mode=(TTA)
set enable=Enabled
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
:thread
echo.
echo.
echo Waifu2x is processing with model: "%name%"
echo Multiplier : %scale%x
echo Denoise    : Lv.%noise%
echo TTA Mode   : %enable%
echo.
for %%a in (%*) do (call :worker "%%~a")
timeout /t 5
exit
:worker
cd /d %1 2>nul
if %errorlevel% equ 0 goto :folder
echo.
echo Processing : "%~1"
"%waifu2x%" -i %1 -o "%~dpn1 (waifu2x)(%name%)(%scale%x)(lv%noise%)%mode%.%format%" -m %model% -n %noise% -s %scale% %tta% 1>nul 2>&1
echo Output     : "%~dpn1 (waifu2x)(%name%)(%scale%x)(lv%noise%)%mode%.%format%"
exit /b
:subworker
echo.
echo Processing : "%~dpnx1"
"%waifu2x%" -i "%~dpnx1" -o "%folder%\%~n1.%format%" -m %model% -n %noise% -s %scale% %tta% 1>nul 2>&1
echo Output     : "%folder%\%~n1.%format%"
exit /b
:folder
set folder=%~1 (waifu2x)(%name%)(%scale%x)(lv%noise%)%mode%
md "%folder%" 2>nul
for %%a in (*) do (call :subworker "%%~a")
exit /b
