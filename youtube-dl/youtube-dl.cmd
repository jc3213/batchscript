@echo off
title Youtube-DL Utilities
pushd %~dp0bin
:switch
if [%2] equ [] goto :Wizard
if %~1 equ -f set preset=%~2
if %~1 equ -o set folder=%~2
if %~1 equ -p set proxy=%~2
if %~1 equ -h set history=%~2
shift
goto :switch
:Wizard
if defined preset goto :%preset%
:quality
echo Select video quality
echo ========================================================================================
echo 1. Best Quality
echo 2. Best Quality @1080p
echo 3. Best Quality @2K
echo 4. Best Quality @4K
echo 5. Only Audio
echo 6. Only Audio (AAC)
echo ========================================================================================
set /p fm=^> 
echo.
echo.
if [%fm%] equ [1] goto :best
if [%fm%] equ [2] goto :1080p
if [%fm%] equ [3] goto :1440p
if [%fm%] equ [4] goto :2160p
if [%fm%] equ [5] goto :audio
if [%fm%] equ [6] goto :aac
goto :quality
:aac
echo Selected Quality: Best Audio Only (AAC)
set format=--format "bestaudio[acodec~='^(aac|mp4a)']"
goto :folder
:audio
echo Selected Quality: Best Audio Only
set format=--format "bestaudio"
goto :folder
:1080p
echo Selected Quality: Best Video ^& Audio Quality @1080p
set format=--format "bestvideo[height<=1080]+bestaudio/best[height<=1080]"
goto :folder
:1440p
echo Selected Quality: Best Video ^& Audio Quality @2K
set format=--format "bestvideo[height<=1440]+bestaudio/best[height<=1440]"
goto :folder
:2160p
echo Selected Quality: Best Video ^& Audio Quality @4K
set format=--format "bestvideo[height<=2160]+bestaudio/best[height<=2160]"
goto :folder
:best
echo Selected Quality: Best Video ^& Audio Quality
set format=--format "bestvideo+bestaudio/best"
:folder
if defined folder goto :path
echo.
echo.
echo Set download folder
echo ========================================================================================
echo %~dp0youtube-dl (Default)
echo ========================================================================================
set /p folder=^> 
if not defined folder set folder=%~dp0youtube-dl
:path
echo.
echo.
echo Download Folder: %folder%
set output=--output "%folder%\%%(title)s.%%(ext)s"
:history
if not defined history goto :proxy
echo.
echo.
echo Download History: %history%
set archive=--download-archive "%history%"
:proxy
if not defined proxy goto :server
echo.
echo.
echo Use proxy server?
echo ========================================================================================
echo 0. No
echo 1. Yes (%proxy%)
echo 2. Other
echo ========================================================================================
set /p px=^> 
if [%px%] equ [0] goto :subtitle
if [%px%] equ [1] goto :prxservr
if [%px%] equ [2] goto :server
goto :proxy
:server
echo.
echo.
set proxy=
echo Set proxy server
echo ========================================================================================
echo 127.0.0.1:1080 (Sample)
echo Keep EMPTY if you don't use a proxy
echo ========================================================================================
set /p proxy=^> 
if not defined proxy goto :subtitle
:prxservr
echo.
echo.
echo Proxy Server: %proxy%
set server=--proxy "%proxy%"
:subtitle
echo.
echo.
echo Download all subtitles?
echo ========================================================================================
echo 1. Yes
echo ========================================================================================
set /p sub=^> 
if /i [%sub%] neq [1] goto :aria2c
echo.
echo.
echo Download subtitles: Yes
:aria2c
if exist aria2c.exe set aria2c=--external-downloader "aria2c" --external-downloader-args "-c -j 10 -x 10 -s 10 -k 1M"
:link
echo.
echo.
set /p url=Video URL: 
if not defined url goto :link
:download
echo.
echo.
youtube-dl.exe %format% %output% %archive% %server% %aria2c% %subtitle% %url%
set url=
goto :link
