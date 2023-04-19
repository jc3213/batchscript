@echo off
pushd %~dp0bin
if not exist "%~1" EXIT
ffmpeg.exe -i "%~1" >%Temp%\ffmpeg_log_%~n1.txt 2>&1
for /f "usebackq skip=13 tokens=4,5 delims=,: " %%a in ("%Temp%\ffmpeg_log_%~n1.txt") do (
	if "%%a"=="Audio" set format=%%J
)
if "%format%"=="aac" call :Extract %1 m4a
if "%format%"=="opus" call :Extract %1 webm
if "%format%"=="mp3" call :Extract %1 mp3
if "%format%"=="vorbis" call :Extract %1 ogg
if "%format%"=="pcm_s16le" call :Extract %1 wav
if "%format%"=="flac" call :Extract %1 flac
if "%format%"=="alac" call :Extract %1 m4a
if not defined ext set /p ext=Audio Format: 
:Extract
ffmpeg.exe -i %1 -vn -acodec copy %~n1.%2
del /S /Q /f %Temp%\ffmpeg_log_%~n1.txt
timeout /t 5
