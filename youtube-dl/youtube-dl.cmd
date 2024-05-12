@echo off
title Youtube-DL Utilities
set youtube=%~dp0bin\youtube-dl.exe
set aria2c=%~dp0bin\aria2c.exe
:format
echo Select video quality
echo ============================================================
echo 1. Best Video and Audio [Default]
echo 2. Best Video and Audio @1080p
echo 3. Best Video and Audio @2K
echo 4. Best Video and Audio @4K
echo 5. Only Audio
echo 6. Only Audio (AAC)
echo ============================================================
set /p format=^> 
if [%format%] equ [2] goto :best1080
if [%format%] equ [3] goto :best1440
if [%format%] equ [4] goto :best2160
if [%format%] equ [5] goto :audiomax
if [%format%] equ [6] goto :audioaac
set params=--format "bestvideo+bestaudio/best"
set quality=Best Video and Audio
goto :folder
:best1080
set params=--format "bestvideo[height<=1080]+bestaudio/best[height<=1080]"
set quality=Best Video and Audio @1080p
goto :folder
:best1440
set params=--format "bestvideo[height<=1440]+bestaudio/best[height<=1440]"
set quality=Best Video and Audio @1440p
goto :folder
:best2160
set params=--format "bestvideo[height<=2160]+bestaudio/best[height<=2160]"
set quality=Best Video and Audio @2160p
goto :folder
:audiomax
set params=--format "bestaudio"
set quality=Best Audio Only
goto :folder
:audioaac
set params=--format "bestaudio[acodec~='^(aac|mp4a)']"
set quality=Best Audio Only (AAC)
:folder
echo.
echo.
echo Set download directory
echo ============================================================
echo %~dp0Youtube-DL [Default]
echo ============================================================
set /p folder=^> 
if not defined folder set folder=%~dp0Youtube-DL
set params=%params% --output "%folder%\%%(title)s.%%(ext)s"
:history
echo.
echo.
echo Save download history?
echo ============================================================
echo Sample: %~dp0Youtube-DL.txt
echo Keep EMPTY to avoid saving download history
echo ============================================================
set /p history=^> 
if not defined history goto :proxy
set params=%params% --download-archive "%history%"
:proxy
echo.
echo.
echo Set proxy server
echo ============================================================
echo Sample: 127.0.0.1:1080
echo Keep EMPTY if you don't use a proxy server
echo ============================================================
set /p proxy=^> 
if not defined proxy goto :subtitle
for /f "delims=:" %%a in ("%proxy%") do (set test=%%a)
ping "%test%" >nul 2>nul && set params=%params% --proxy "%proxy%" || set proxy=
:subtitle
echo.
echo.
echo Download all subtitles?
echo ============================================================
echo 1. Yes
echo 0. No [Default]
echo ============================================================
set /p sb=^> 
if [%sb%] neq [1] goto :aria2c
set subtitle=all
set params=%params% --all-subs
:aria2c
if not exist "%aria2c%" goto :dialog
set params=%params% --external-downloader "aria2c" --external-downloader-args "--continue=true --split=10 --min-split-size=1M --max-connection-per-server=10 --disk-cache 128M"
:dialog
cls
echo ============================================================
echo Selected Quality    :   %quality%
echo Download Directory  :   %folder%
if defined history echo Download History    :   %history%
if defined proxy echo Proxy Server        :   %proxy%
if defined subtitle echo Download Subtitles  :   all
if exist "%aria2c%" echo External Downloader :   aria2c
echo ============================================================
echo.
set /p uri=Video URI: 
if not defined uri goto :dialog
:download
echo.
echo Youtube-DL is downloading: "%uri%"
"%youtube%" %params% "%uri%"
echo Youtube-DL has completed:  "%uri%"
set uri=
timeout /t 5
goto :dialog
