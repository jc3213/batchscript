@echo off
pushd %~dp0bin
if not exist "%~1" EXIT
for %%a in (%*) do (call :Audio %%a)
timeout /t 5
exit
:Audio
for /f "tokens=3,4 delims= " %%a in ('ffmpeg.exe -i %1 2^>^&1 ^| findstr /i "audio"') do (if %%a equ Audio: set Codec=%%b)
if [%Codec%] equ [aac] set Format=m4a
if [%Codec%] equ [opus] set Format=webm
if [%Codec%] equ [mp3] set Format=mp3
if [%Codec%] equ [vorbis] set Format=ogg
if [%Codec%] equ [pcm_s16le] set Format=wav
if [%Codec%] equ [flac] set Format=flac
if [%Codec%] equ [alac] set Format=m4a
if defined Format goto :Extract
echo ==========================================================================
echo Unknown audio format of %1
echo The audio codec is %Codec%
echo Please set the file extention
echo ==========================================================================
:Format
set /p Format=^> 
echo.
if not defined Format goto :Format
:Extract
ffmpeg.exe -i %1 -vn -acodec copy %~dpn1.%Format%
exit /b
