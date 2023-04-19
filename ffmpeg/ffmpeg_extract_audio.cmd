@echo off
pushd %~dp0bin
for %%a in (%*) do (call :Audio %%a)
timeout /t 5
exit
:Audio
for /f "tokens=3,4 delims= " %%a in ('ffmpeg.exe -i %1 2^>^&1 ^| findstr /i "audio"') do (if %%a equ Audio: set codec=%%b)
if [%codec%] equ [aac] set ext=m4a
if [%codec%] equ [opus] set ext=webm
if [%codec%] equ [mp3] set ext=mp3
if [%codec%] equ [vorbis] set ext=ogg
if [%codec%] equ [pcm_s16le] set ext=wav
if [%codec%] equ [flac] set ext=flac
if [%codec%] equ [alac] set ext=m4a
if defined ext goto :Extract
echo ==========================================================================
echo Unknown audio codec %codec% of %~nx1
echo Please set the file extention
echo ==========================================================================
:Format
set /p ext=^> 
echo.
if not defined ext goto :Format
:Extract
ffmpeg.exe -i %1 -vn -acodec copy %~dpn1.%ext%
