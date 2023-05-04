@echo off
pushd %~dp0bin
for %%a in (%*) do (call :codec %%a)
timeout /t 5
exit
:codec
for /f "tokens=3,4 delims= " %%a in ('ffmpeg.exe -i %1 2^>^&1 ^| findstr /i "audio"') do (if %%a equ Audio: set codec=%%b)
if [%codec%] equ [aac] set ext=m4a
if [%codec%] equ [opus] set ext=webm
if [%codec%] equ [mp3] set ext=mp3
if [%codec%] equ [vorbis] set ext=ogg
if [%codec%] equ [pcm_s16le] set ext=wav
if [%codec%] equ [flac] set ext=flac
if [%codec%] equ [alac] set ext=m4a
if defined ext goto :extract
echo Unknown codec detected
echo ==========================================================================
echo File name: %~nx1
echo Audio codec: %codec%
echo Please set file extension
echo ==========================================================================
:format
set /p ext=^> 
echo.
if not defined ext goto :format
:extract
ffmpeg.exe -i %1 -vn -acodec copy %~dpn1.%ext%
