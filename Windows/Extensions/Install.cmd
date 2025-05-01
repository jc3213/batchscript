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
echo ===================================================================
set /p sel=^> 
if "%sel%" equ "1" call :install "WebP Image" "WebpImage"
if "%sel%" equ "2" call :install "HEIF Image" "HEIFImage"
if "%sel%" equ "3" call :install "AV1 Video" "AV1Video"
goto :main
:install
echo.
powershell -Command "Add-AppxPackage -Path 'Microsoft.%~2Extension_*_neutral_~_8wekyb3d8bbwe.AppxBundle'"
echo %~1 Extension has been installed successfully!
echo.
timeout /t 5
exit /b
