@echo off
net session >nul 2>nul && goto :admin
mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c ""%~s0"" %*","","runas",1)(window.close)
exit
:admin
setlocal
pushd %~dp0
title Windows Extensions
:main
cls
echo ===================================================================
echo 1. WebP image extension
echo 2. HEIF image extension
echo 3. RAW image extension
echo 4. AV1 video extension
echo 5. HEVC video extensions
echo 6. VP9 video extensions
echo 7. MPEG-2 video extension
echo 8. Web media extensions (OGG, Vorbis, Theora)
echo a. All image extensions
echo b. All video extensions
echo *. All video and image extensions
echo x. Install VCLibs
echo ===================================================================
set /p app=^> 
if "%app%" equ "1" call :install "WebP image extension" "WebpImage"
if "%app%" equ "2" call :install "HEIF image extension" "HEIFImage"
if "%app%" equ "3" call :install "RAW image extension" "RawImage"
if "%app%" equ "4" call :install "AV1 video extension" "AV1Video"
if "%app%" equ "5" call :install "HEVC video extensions" "HEVCVideo"
if "%app%" equ "6" call :install "VP9 video extensions" "VP9Video"
if "%app%" equ "7" call :install "MPEG-2 video extension" "MPEG2Video"
if "%app%" equ "8" call :install "Web media extensions"  "WebMedia"
if "%app%" equ "a" call :install "All image extensions" "*Image"
if "%app%" equ "b" call :install "All video extensions" "*Video"
if "%app%" equ "*" call :install "All video and image extensions" "*"
goto :main
:install
echo.
powershell -Command "Add-AppxPackage -Path 'Microsoft.%~2Extension*_neutral_~_8wekyb3d8bbwe.AppxBundle'"
goto :back
:depend
powershell -Command "Add-AppxPackage -Path 'Microsoft.VCLibs.*__8wekyb3d8bbwe.Appx'"
:back
set app=
timeout /t 5
goto :main
