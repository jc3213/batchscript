@echo off
setlocal
pushd %~dp0
title Windows Extensions
:main
cls
echo ===================================================================
echo 1. WebP image extension
echo 2. HEIF image extension
echo 3. AV1 video extension
echo 4. HEVC video extensions
echo 5. VP9 video extensions
echo 6. MPEG-2 video extension
echo a. All image extensions
echo b. All video extensions
echo 0. All video and image extensions
echo ===================================================================
set /p app=^> 
if "%app%" equ "1" call :install "WebP image extension" "WebpImage"
if "%app%" equ "2" call :install "HEIF image extension" "HEIFImage"
if "%app%" equ "3" call :install "AV1 video extension" "AV1Video"
if "%app%" equ "4" call :install "HEVC video extensions" "HEVCVideo"
if "%app%" equ "5" call :install "VP9 video extensions" "VP9Video"
if "%app%" equ "6" call :install "MPEG-2 video extension" "MPEG2Video"
if "%app%" equ "a" call :install "All image extensions" "*Image"
if "%app%" equ "b" call :install "All video extensions" "*Video"
if "%app%" equ "0" call :install "All video and image extensions" "*"
goto :main
:install
echo.
powershell -Command "Add-AppxPackage -Path 'Microsoft.%~2Extension*_neutral_~_8wekyb3d8bbwe.AppxBundle'"
echo.
set app=
timeout /t 5
goto :main
