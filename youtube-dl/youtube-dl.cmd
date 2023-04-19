@echo off
pushd %~dp0bin
:Switch
if [%1] equ [] goto :Wizard
if [%2] equ [] goto :Wizard
if %~1 equ -f set template=%~2
if %~1 equ -o set folder=%~2
if %~1 equ -p set proxy=%~2
if %~1 equ -h set history=%~2
shift
goto :Switch
:Wizard
if defined template goto :%template%
:Format
echo Select video format
echo ========================================================================================
echo 1. Best Quality
echo 2. Best Quality @1080p
echo 3. Best Quality @2K
echo 4. Best Quality @4K
echo 5. Only Audio
echo 6. Only Audio (AAC)
echo ========================================================================================
:FormatTemplate
set /p fm=^> 
echo.
echo.
if [%fm%] equ [1] goto :Best
if [%fm%] equ [2] goto :1080p
if [%fm%] equ [3] goto :1440p
if [%fm%] equ [4] goto :2160p
if [%fm%] equ [5] goto :Audio
if [%fm%] equ [6] goto :AAC
if not defined format goto :FormatTemplate
:AAC
echo Selected Format: Best Audio Only (AAC)
set format=--format "bestaudio[acodec~='^(aac|mp4a)']"
goto :Folder
:Audio
echo Selected Format: Best Audio Only
set format=--format "bestaudio"
goto :Folder
:1080p
echo Selected Format: Best Video Quality @1080p
set format=--format "bestvideo[height<=1080]+bestaudio/best[height<=1080]"
goto :Folder
:1440p
echo Selected Format: Best Video Quality @2K
set format=--format "bestvideo[height<=1440]+bestaudio/best[height<=1440]"
goto :Folder
:2160p
echo Selected Format: Best Video Quality @4K
set format=--format "bestvideo[height<=2160]+bestaudio/best[height<=2160]"
goto :Folder
:Best
echo Selected Format: Best Video Quality
set format=--format "bestvideo+bestaudio/best"
:Folder
if defined folder goto :FolderPath
echo.
echo.
echo set download folder
echo ========================================================================================
echo %~dp0youtube-dl (Default)
echo ========================================================================================
set /p folder=^> 
if not defined folder set folder=%~dp0youtube-dl
:FolderPath
echo.
echo.
echo Download Folder: %folder%
set output=--output "%folder%\%%(title)s.%%(ext)s"
:History
if not defined history goto :Proxy
echo.
echo.
echo Download History: %history%
set archive=--download-archive "%history%"
:Proxy
if not defined proxy goto :Server
echo.
echo.
echo Use proxy server?
echo ========================================================================================
echo 0. No
echo 1. Yes (%proxy%)
echo 2. Other
echo ========================================================================================
set /p px=^> 
if [%px%] equ [0] goto :Subtitle
if [%px%] equ [1] goto :ProxyServer
if [%px%] equ [2] goto :Server
goto :Proxy
:Server
echo.
echo.
echo set proxy server
echo ========================================================================================
echo 127.0.0.1:1080 (Sample)
echo Keep EMPTY if you don't use a proxy
echo ========================================================================================
set proxy=
set /p proxy=^> 
if not defined proxy goto :Subtitle
:ProxyServer
echo.
echo.
echo Proxy Server: %proxy%
set server=--proxy "%proxy%"
:Subtitle
echo.
echo.
echo Download all subtitles?
echo ========================================================================================
echo 0. No
echo 1. Yes
echo ========================================================================================
set /p sub=^> 
if [%sub%] equ [1] set subtitle=--all-subs
:Aria2c
if exist aria2c.exe set aria2c=--external-downloader "aria2c" --external-downloader-args "-c -j 10 -x 10 -s 10 -k 1M"
:Link
echo.
echo.
set attempt=0
set /p url=Video URL: 
if not defined url goto :Link
:Download
echo.
echo.
youtube-dl.exe %format% %output% %archive% %server% %aria2c% %subtitle% %url%
set url=
goto :Link
