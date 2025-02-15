@echo off
setlocal enabledelayedexpansion
title Manga Denoise and Super Sampling
echo ===================================================================
echo Use Real-CUGAN for Denoise and Upscale
echo Use ImageMagick for Super Sampling
echo ===================================================================
set start=%time%
for %%a in (%*) do (call :fixer "%%~a")
set finish=%time%
set /a hour=%finish:~0,2%-%start:~0,2%
set /a minute=%finish:~3,2%-%start:~3,2%
set /a second=%finish:~6,2%-%start:~6,2%
set /a millisecond=%finish:~9,2%-%start:~9,2%
if %millisecond% lss 0 (
    set /a millisecond+=100
    set /a second-=1
)
if %second% lss 0 (
    set /a second+=60
    set /a minute-=1
)
if %minute% lss 0 (
    set /a minute+=60
    set /a hour-=1
)
if %hour% lss 0 (
    set /a hour+=24
)
if %hour% neq 0 (
    set dur=%hour%:%minute%:%second%.%millisecond%
) else if %minute% neq 0 (
    set dur=%minute%:%second%.%millisecond%
) else (
    set dur=%second%.%millisecond%
)
echo.
echo.
echo Elapsed  : %dur%
endlocal
pause
exit
:fixer
set tempxx=%~dp1_temp_
set result=%~dp1_result_
cd /d %1 2>nul
if %errorlevel% equ 0 goto :folder
md %tempxx% 2>nul
md %result% 2>nul
goto :result
exit /b
:folder
set tempxx=%tempxx%\%~nx1
set result=%result%\%~nx1
md "%tempxx%" 2>nul
md "%result%" 2>nul
for %%a in (*) do (call :result "%%~a")
exit /b
:reult
echo.
echo.
echo Fixing   : "%~dpnx1"
"%~dp0bin\realcugan-ncnn-vulkan.exe" -i "%~1" -o "%tempxx%\%~n1.png" -m models-se -s 2 -n 1 -t 44 -x >nul 2>nul
"%~dp0bin\magick.exe" "%tempxx%\%~n1.png" -resize x1600 -quality 90 "%result%\%~n1.jpg" >nul 2>nul
echo Result   : "%result%\%~n1.jpg"
exit /b
