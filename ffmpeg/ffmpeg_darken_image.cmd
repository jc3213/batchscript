@echo off
set ffmpeg=%~dp0bin\ffmpeg.exe
set params=-loglevel quiet -y -vf colorlevels=rimin=0.3:gimin=0.3:bimin=0.3
cd /d %1 2>nul
if %errorlevel% equ 0 goto :folder
"%ffmpeg%" -i %1 %params% "%~dp1dark_%~nx1"
exit
:folder
md "%~dp1dark_%~nx1" 2>nul
for %%a in (*) do ("%ffmpeg%" -i "%%a" %params% "%~dp1dark_%~nx1\%%~nxa")
