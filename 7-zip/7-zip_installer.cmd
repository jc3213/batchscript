@echo off
pushd %~dp0
title 7-Zip Installer
for /f "tokens=3 delims= " %%a in ('curl https://7-zip.org/ --silent ^| findstr /c:"Download 7-Zip"') do (set ver=%%a)
if %Processor_Architecture% equ AMD64 set arc=-x64
if %Processor_Architecture% equ ARM64 set arc=-arm64
set app=7z%ver:.=%%arc%.exe
set url=https://7-zip.org/a/%app%
curl %url% --location --output %app%
echo.
echo.
echo Install - 7-Zip %ver%
%app% /S /D="%ProgramFiles%\7-Zip"
echo.
echo.
del /s /q %app%
echo.
echo.
echo Done!
timeout /t 5
