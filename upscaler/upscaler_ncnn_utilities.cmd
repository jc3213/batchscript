@echo off
setlocal enabledelayedexpansion
title Image Upscale Utilities
:menu
cls
echo ===================================================================
echo 1. Real-ESRGAN Plus Anime
echo 2. Real-ESRGAN Anime Video v3
echo 3. Real-CUGAN Se
echo 4. Real-CUGAN Pro
echo 5. Waifu2x CUnet
echo 6. Waifu2x Anime Style
echo ===================================================================
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
set engine=Real-ESRGAN
set model=x4plus-anime
set name=(%app%)(x4plus-anime)(4x)
set scale=4
set params=-n %app%-%model%
goto :tile
:videoanime
set app=realesrgan
set engine=Real-ESRGAN
set model=animevideov3
set name=(%app%)(animevideov3)
set params=-n realesr-%model%
call :scale
goto :tile
:cuganse
set app=realcugan
set engine=Real-CUGAN
set model=se
set name=(%app%)(se)
set params=-m models-%model%
call :scale
goto :noiscu
:cuganpro
set app=realcugan
set engine=Real-CUGAN
set model=pro
set name=(%app%)(pro)(2x)
set scale=2
set params=-m models-%model%
goto :noiscu
:cunet
set app=waifu2x
set engine=Waifu2x
set model=cunet
set name=(%app%)(cunet)
set params=-m models-%model%
call :scale
goto :noise
:style
set app=waifu2x
set engine=Waifu2x
set model=upconv_7_anime_style_art_rgb
set name=(%app%)(upconv_7_anime_style_art_rgb)
set params=-m models-%model%
call :scale
goto :noise
:scale
echo.
echo.
echo ===================================================================
echo 1. Scale 2x [Default]
echo 2. Scale 4x
echo ===================================================================
set /p sc=^> 
if [%sc%] equ [2] set scale=4
if not defined scale set scale=2
set name=%name%(%scale%x)
set params=%params% -s %scale%
exit /b
:noise
echo.
echo.
echo ===================================================================
echo Denoise Level: 0 ~ 3
echo Default: 0
echo ===================================================================
set /p noise=^> 
echo %noise%| findstr /r "^[0-3]$" >nul || set noise=0
set name=%name%(lv%noise%)
set params=%params% -n %noise%
goto :tile
:noiscu
echo.
echo.
echo ===================================================================
echo Denoise Level: -1 ~ 3
echo Default: 0
echo ===================================================================
set /p noise=^> 
echo %noise%| findstr /r "^[0-3]$ ^-1$" >nul || set noise=0
set name=%name%(lv%noise%)
set params=%params% -n %noise%
:tile
echo.
echo.
echo ===================================================================
echo Split Tiles: 0 ~ 144
echo Default: 0 (Auto)
echo ===================================================================
set /p tile=^> 
echo %tile%| findstr /r "^[0-9]$ ^[1-9][0-9]$ ^1[0-3][0-9]$ ^14[1-4]$" >nul || set tile=0
set params=%params% -t %tile%
:tta
echo.
echo.
echo ===================================================================
echo 1. Enable TTA Mode
echo ===================================================================
set /p tta=^> 
if [%tta%] neq [1] goto :format
set name=%name%(TTA)
set params=%params% -x
:format
echo.
echo.
echo ===================================================================
echo 1. jpg
echo 2. png [Default]
echo 3. webp
echo ===================================================================
set /p fm=^> 
if [%fm%] equ [1] set format=.jpg
if [%fm%] equ [3] set format=.webp
if not defined format set format=.png
:main
set start=%time%
cls
echo ===================================================================
echo Engine     :   %engine%
echo Model      :   %model%
echo Scale      :   %scale%x
if %tile% equ 0 (echo Tiles      :   Auto) else (echo Tiles      :   %tile%)
if defined noise echo Denoise    :   Lv.%noise%
if [%tta%] equ [1] echo TTA Mode   :   Enabled
echo ===================================================================
for %%a in (%*) do (call :upscale "%%~a")
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
echo.
echo.
echo Elapsed   : %hour%:%minute%:%second%.%millsec%
endlocal
pause
exit
:upscale
set folder=%~dp1
cd /d %1 2>nul
if %errorlevel% equ 0 goto :folder
set output= %name%%format%
goto :output
:folder
set folder=%folder%%~nx1 %name%\
set output=%format%
md "%folder%" 2>nul
for %%a in (*) do (call :output "%%~a")
exit /b
:output
echo.
echo.
echo Upscaling : "%~dpnx1"
"%~dp0upscaler\%app%-ncnn-vulkan.exe" -i "%~1" -o "%folder%%~n1%output%" %params% >nul 2>nul
echo Output    : "%folder%%~n1%output%"
exit /b
