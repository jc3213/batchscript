@echo off
pushd %~dp0
title 7-Zip Installer
for /f "tokens=3 delims= " %%a in ('curl https://7-zip.org/ --silent ^| findstr /r /c:"Download 7-Zip"') do (set ver=%%a)
if %Processor_Architecture% equ AMD64 set arc=-x64
if %Processor_Architecture% equ ARM64 set arc=-arm64
set app=7z%ver:.=%%arc%.exe
set url=https://7-zip.org/a/%app%
if exist %app% goto :install
curl %url% --location --output %app%
echo.
echo.
:install
echo Install - 7-Zip %ver%
echo %app% /S /D="%ProgramFiles%\7-Zip"
echo.
echo.
echo del /s /q %app%
echo.
echo.
echo Done!
timeout /t 5
