@echo off
setlocal
pushd %~dp0
title Windows Extensions
:main
cls
echo ===================================================================
echo 1. WebP Image Extension
echo 2. HEIF Image Extension
echo 3. AV1 Video Extension
echo 4. HEVC Video Extensions
echo 5. VP9 Video Extensions
echo 6. MPEG-2 Video Extension
echo a. Install image extensions
echo b. Install video extensions
echo 0. Install all extensions
echo ===================================================================
set /p sel=^> 
if "%sel%" equ "1" call :install "WebP Image Extension" "WebpImage"
if "%sel%" equ "2" call :install "HEIF Image Extension" "HEIFImage"
if "%sel%" equ "3" call :install "AV1 Video Extension" "AV1Video"
if "%sel%" equ "4" call :install "HEVC Video Extensions" "HEVCVideo"
if "%sel%" equ "5" call :install "VP9 Video Extensions" "VP9Video"
if "%sel%" equ "6" call :install "MPEG-2 Video Extension" "MPEG2Video"
if "%sel%" equ "a" call :install "Image Extensions" "*Image"
if "%sel%" equ "b" call :install "Video Extensions" "*Video"
if "%sel%" equ "0" call :install "All Extensions" "*"
goto :main
:install
echo.
powershell -Command "Add-AppxPackage -Path 'Microsoft.%~2Extension*_neutral_~_8wekyb3d8bbwe.AppxBundle'"
echo %~1 has been installed successfully!
echo.
timeout /t 5
exit /b
