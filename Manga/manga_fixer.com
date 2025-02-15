@echo off
setlocal enabledelayedexpansion
title Manga Denoise and Super Sampling
echo ============================================================
echo Use Real-CUGAN for Denoise and Upscale
echo Use ImageMagick for Super Sampling
echo ============================================================
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
cd /d %1 2>nul
if %errorlevel% equ 0 goto :folder
md _tempxx_ 2>nul
md _result_ 2>nul
set tempxx=%~dp1_tempxx_\%~n1.png
set result=%~dp1_result_\%~n1.jpg
call :reult %1
exit /b
:folder
set folder=%~dp1_result_\%~nx1
md "%folder%" 2>nul
set foldxx=%~dp1_tempxx_\%~nx1
md "%foldxx%" 2>nul
for %%a in (*) do (call :files "%%~a")
exit /b
:files
set tempxx=%foldxx%\%~n1.png
set result=%folder%\%~n1.jpg
:reult
echo.
echo.
echo Fixing   : "%~dpnx1"
"%~dp0bin\realcugan-ncnn-vulkan.exe" -i "%~1" -o "%tempxx%" -m models-se -s 2 -n 1 -t 44 -x >nul 2>nul
"%~dp0bin\magick.exe" "%tempxx%" -resize x1600 -quality 90 "%result%" >nul 2>nul
echo Result   : "%result%"
exit /b
