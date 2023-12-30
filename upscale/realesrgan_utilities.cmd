@echo off
title Real-ESRGAN Utilities
set realesrgan=%~dp0bin\realesrgan-ncnn-vulkan.exe
:main
cls
echo ============================================================
echo 1. Real-ESRGAN Plus
echo 2. Real-ESRGAN Plus Anime
echo 3. Real-ESRGAN Anime Video v3
echo ============================================================
set /p act=^> 
if [%act%] equ [1] goto :realesrplus
if [%act%] equ [2] goto :realesranime
if [%act%] equ [3] goto :realesrvideov3
goto :main
:realesrplus
set model=realesrgan-x4plus
set name=x4plus
set scale=4
goto :format
:realesranime
set model=realesrgan-x4plus-anime
set name=x4plus-anime
set scale=4
goto :format
:realesrvideov3
echo.
echo.
echo ============================================================
echo 1. x2
echo 2. x3
echo 3. x4
echo ============================================================
set /p op=^> 
if [%op%] equ [1] set scale=2
if [%op%] equ [2] set scale=3
if [%op%] equ [3] set scale=4
if defined scale goto :submodelv3
goto :realesrvideov3
:submodelv3
set model=realesr-animevideov3
set name=animevideov3
set extra=-s %scale%
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
echo Real-ESRGAN is processing with model: "%model%"
echo Multiplier: %scale%x
echo.
for %%a in (%*) do (call :worker "%%~a")
timeout /t 5
exit
:worker
cd /d %1 2>nul
if %errorlevel% equ 0 goto :folder
echo.
echo Processing: "%~1"
"%realesrgan%" -i %1 -o "%~dpn1 (Real-ESRGAN)(%name%)(%scale%x).%format%" -n %model% %extra% 1>nul 2>&1
echo Output: "%~dpn1 (Real-ESRGAN)(%name%)(%scale%x).%format%"
exit /b
:subworker
echo.
echo Processing: "%~dpnx1"
"%realesrgan%" -i "%~dpnx1" -o "%folder%\%~n1.%format%" -n %model% %extra% 1>nul 2>&1
echo Output: "%folder%\%~n1.%format%"
exit /b
:folder
set folder=%~1 (Real-ESRGAN)(%name%)(%scale%x)
md "%folder%" 2>nul
for %%a in (*) do (call :subworker "%%~a")
exit /b
