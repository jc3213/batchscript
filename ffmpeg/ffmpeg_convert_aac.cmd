@echo off
pushd %~dp0bin
:Files
if not exist "%1" goto :Exit
ffmpeg.exe -i "%1" -strict experimental -c:a aac -b:a 512k %~n1.aac
for /f "tokens=1,* delims= " %%a in ("%*") do call :Files %%b
:Exit
timeout /t 5
