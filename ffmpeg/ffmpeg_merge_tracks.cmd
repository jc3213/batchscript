@echo off
pushd %~dp0bin
set /a index=0
set File=%~x1
:Files
if not exist "%~1" goto :Proc
set input=-i "%1" %input%
set /a index+=1
for /f "tokens=1,* delims= " %%a in ("%*") do call :Files %%b
:Proc
if not defined input goto :End
ffmpeg.exe %input% -filter_complex "amerge=inputs=%index%" merged_audio_track%File%
:End
timeout /t 5
