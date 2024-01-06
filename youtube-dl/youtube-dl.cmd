@echo off
title Youtube-DL Utilities
set youtube=%~dp0bin\youtube-dl.exe
set aria2c=%~dp0bin\aria2c.exe
:format
echo Select video quality
echo ========================================================================================
echo 1. Best Quality [Default]
echo 2. Best Quality @1080p
echo 3. Best Quality @2K
echo 4. Best Quality @4K
echo 5. Only Audio
echo 6. Only Audio (AAC)
echo ========================================================================================
set /p format=^> 
if [%format%] equ [2] set params=--format "bestvideo[height<=1080]+bestaudio/best[height<=1080]"
if [%format%] equ [3] set params=--format "bestvideo[height<=1440]+bestaudio/best[height<=1440]"
if [%format%] equ [4] set params=--format "bestvideo[height<=2160]+bestaudio/best[height<=2160]"
if [%format%] equ [5] set params=--format "bestaudio"
if [%format%] equ [6] set params=--format "bestaudio[acodec~='^(aac|mp4a)']"
if defined params goto :folder
set format=1
set params=--format "bestvideo+bestaudio/best"
:folder
echo.
echo.
echo Set download directory
echo ========================================================================================
echo %~dp0Youtube-DL [Default]
echo ========================================================================================
set /p folder=^> 
if defined folder goto :history
set folder=%~dp0Youtube-dl
:history
echo.
echo.
echo Save download history?
echo ========================================================================================
echo Sample: %~dp0Youtube-DL.txt
echo Keep EMPTY to avoid saving download history
echo ========================================================================================
set /p history=^> 
if not defined history goto :proxy
set params=%params% --output "%folder%\%%(title)s.%%(ext)s" --download-archive "%history%"
:proxy
echo.
echo.
echo Set proxy server
echo ========================================================================================
echo Sample: 127.0.0.1:1080
echo Keep EMPTY if you don't use a proxy server
echo ========================================================================================
set /p proxy=^> 
if not defined proxy goto :subtitle
for /f "delims=:" %%a in ("%proxy%") do (set test=%%a)
ping "%test%" >nul 2>nul && set params=%params% --proxy "%proxy%" || set proxy=
:subtitle
echo.
echo.
echo Download all subtitles?
echo ========================================================================================
echo 1. Yes
echo 0. No [Default]
echo ========================================================================================
set /p subtitle=^> 
if /i [%subtitle%] neq [1] goto :aria2c
set params=%params% --all-subs
:aria2c
echo.
echo.
if [%format%] equ [1] echo Selected Quality    :   Best Video ^& Audio
if [%format%] equ [2] echo Selected Quality    :   Best Video ^& Audio @4K
if [%format%] equ [3] echo Selected Quality    :   Best Video ^& Audio @2K
if [%format%] equ [4] echo Selected Quality    :   Best Video ^& Audio @1080p
if [%format%] equ [5] echo Selected Quality    :   Best Audio Only
if [%format%] equ [6] echo Selected Quality    :   Best Audio Only (AAC)
echo Download Folder     :   %folder%
if defined history echo Download History    :   %history%
if defined proxy echo Proxy Server        :   %proxy%
if defined subtitle echo Download Subtitles  :   Yes
if not exist "%aria2c%" goto :link
echo External Downloader :   aria2c
set params=%params% --external-downloader "aria2c" --external-downloader-args "-c -j 10 -x 10 -s 10 -k 1M"
:dialog
echo.
echo.
set /p uri=Video URI: 
if not defined uri goto :link
:download
echo.
echo.
"%youtube%" %params% "%uri%"
set uri=
goto :link
