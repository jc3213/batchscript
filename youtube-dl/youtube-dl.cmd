@ECHO OFF
PUSHD %~DP0bin
:Switch
IF "%1" EQU "" GOTO :Wizard
IF "%2" EQU "" GOTO :Wizard
IF %~1 EQU -f SET template=%~2
IF %~1 EQU -o SET folder=%~2
IF %~1 EQU -p SET proxy=%~2
IF %~1 EQU -a SET history=%~2
IF %~1 EQU -r SET retry=%~2
SHIFT
GOTO :Switch
:Wizard
IF DEFINED template CALL :%template%
:Format
IF DEFINED format GOTO :Folder
ECHO Select video format
ECHO ========================================================================================
ECHO 1. Best Quality
ECHO 2. Best Quality @1080p
ECHO 3. Best Quality @2K
ECHO 4. Best Quality @4K
ECHO 5. Only Audio
ECHO 6. Only Audio (AAC)
ECHO ========================================================================================
:FormatTemplate
SET /P fm=^> 
IF %fm% EQU 1 CALL :Best
IF %fm% EQU 2 CALL :1080p
IF %fm% EQU 3 CALL :1440p
IF %fm% EQU 4 CALL :2160p
IF %fm% EQU 5 CALL :Audio
IF %fm% EQU 6 CALL :AAC
IF NOT DEFINED format GOTO :FormatTemplate
ECHO.
ECHO.
:Folder
IF DEFINED folder GOTO :FolderPath
ECHO Set download folder
ECHO ========================================================================================
ECHO %~DP0youtube-dl (Default)
ECHO ========================================================================================
SET /P folder=^> 
IF NOT DEFINED folder SET folder=%~DP0youtube-dl
:FolderPath
ECHO.
ECHO.
ECHO Download Folder: %folder%
SET output=--output "%folder%\%%(title)s.%%(ext)s"
ECHO.
ECHO.
:Proxy
IF NOT DEFINED proxy GOTO :Server
ECHO Use proxy server?
ECHO ========================================================================================
ECHO 0. No
ECHO 1. Yes (%proxy%)
ECHO 2. Other
ECHO ========================================================================================
SET /P px=^> 
ECHO.
ECHO.
IF %px% EQU 0 GOTO :History
IF %px% EQU 1 GOTO :ProxyServer
IF %px% EQU 2 GOTO :Server
GOTO :Proxy
:Server
ECHO Set proxy server
ECHO ========================================================================================
ECHO 127.0.0.1:1080 (Sample)
ECHO Keep EMPTY if you don't use a proxy
ECHO ========================================================================================
SET proxy=
SET /P proxy=Proxy Server: 
ECHO.
ECHO.
IF NOT DEFINED proxy GOTO :Subtitle
:ProxyServer
ECHO Proxy Server: %proxy%
SET server=--proxy "%proxy%"
ECHO.
ECHO.
:Subtitle
ECHO Download all subtitles?
ECHO ========================================================================================
ECHO 0. No
ECHO 1. Yes
ECHO ========================================================================================
SET /P sub=^> 
IF %sub% EQU 1 SET subtitle=--all-subs
:History
IF DEFINED history SET archive=--download-archive "%history%"
:Retry
IF NOT DEFINED retry SET retry=5
:Aria2c
IF EXIST aria2c.exe SET aria2c=--external-downloader "aria2c" --external-downloader-args "-c -j 10 -x 10 -s 10 -k 1M"
:Link
ECHO.
ECHO.
SET attempt=0
SET /P url=Video URL: 
IF NOT DEFINED url GOTO :Link
:Download
youtube-dl.exe %format% %output% %archive% %server% %aria2c% %subtitle% %url% && GOTO :Finish
CALL :Retry
GOTO :Download
:Retry
IF %retry% EQU %attempt% GOTO :Finish
SET /A attempt=%attempt%+1
ECHO.
ECHO.
TIMEOUT /T 5
ECHO.
ECHO.
EXIT /B
:Finish
SET url=
ECHO.
ECHO.
GOTO :Link
:Audio
ECHO Selected Format: Best Audio Only
SET format=--format "bestaudio"
EXIT /B
:AAC
ECHO Selected Format: Best Audio Only (AAC)
SET format=--format "bestaudio[acodec~='^(aac|mp4a)']"
EXIT /B
:Best
ECHO Selected Format: Best Video Quality
SET format=--format "bestvideo+bestaudio/best"
EXIT /B
:1080p
ECHO Selected Format: Best Video Quality @1080p
SET format=--format "bestvideo[height<=1080]+bestaudio/best[height<=1080]"
EXIT /B
:1440p
ECHO Selected Format: Best Video Quality @2K
SET format=--format "bestvideo[height<=1440]+bestaudio/best[height<=1440]"
EXIT /B
:2160p
ECHO Selected Format: Best Video Quality @4K
SET format=--format "bestvideo[height<=2160]+bestaudio/best[height<=2160]"
EXIT /B
