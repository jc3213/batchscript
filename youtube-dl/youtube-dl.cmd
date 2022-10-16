@ECHO OFF
PUSHD %~DP0
SETLOCAL EnableDelayedExpansion
:Environment
IF NOT EXIST youtube-dl.conf GOTO :Wizard
FOR /F "tokens=1,2 delims==" %%I IN ('type youtube-dl.conf') DO (
    IF %%I EQU format CALL :%%J 2>NUL
    IF %%I EQU folder SET folder=%%J
    IF %%I EQU proxy SET proxy=%%J
    IF %%I EQU history SET history=%%J
    IF %%I EQU retry SET retry=%%J
)
:Wizard
CALL :Format
CALL :Folder
CALL :Proxy
GOTO :Config
:Format
If DEFINED format GOTO :Folder
ECHO Set video format
ECHO ========================================================================================
ECHO 0. Audio Only
ECHO 1. Best Quality
ECHO 2. Best Quality @1080p
ECHO 3. Best Quality @2K
ECHO 4. Best Quality @4K
ECHO ========================================================================================
SET /P fm=^> 
ECHO.
ECHO.
IF %fm% EQU 0 CALL :Audio
IF %fm% EQU 1 CALL :Best
IF %fm% EQU 2 CALL :1080p
IF %fm% EQU 3 CALL :2K
IF %fm% EQU 4 CALL :4K
IF NOT DEFINED format GOTO :Format
ECHO.
ECHO.
EXIT /B
:Folder
IF DEFINED folder GOTO :Output
ECHO Set download folder
ECHO ========================================================================================
ECHO %~DP0Download (Default)
ECHO ========================================================================================
SET /P folder=^> 
IF NOT DEFINED folder SET folder=%~DP0Download
ECHO.
ECHO.
:Output
ECHO Download Folder: %folder%
SET output=--output "!folder!\%%(title)s.%%(ext)s"
ECHO.
ECHO.
EXIT /B
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
IF %px% EQU 2 GOTO :Server
IF %px% EQU 1 GOTO :PrxSvr
IF %px% EQU 0 GOTO :Wizard
GOTO :Bypass
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
:PrxSvr
IF DEFINED proxy SET server=--proxy "!proxy!"
EXIT /B
:Config
IF DEFINED history SET archive=--download-archive "!history!"
IF NOT DEFINED retry SET retry=5
PUSHD bin
:Aria2c
IF NOT EXIST aria2c.exe GOTO :Link
ECHO Use aria2c download manager?
ECHO ========================================================================================
ECHO 0. No
ECHO 1. Yes
ECHO ========================================================================================
SET /P external=^> 
ECHO.
ECHO.
IF %external% EQU 1 SET aria2c=--external-downloader "aria2c" --external-downloader-args "-c -j 10 -x 10 -s 10 -k 1M"
:Link
SET attempt=0
SET /P url=Video URL: 
ECHO.
ECHO.
IF "%url%" EQU "@format" GOTO :NewFormat
IF "%url%" EQU "@folder" GOTO :NewFolder
IF "%url%" EQU "@proxy" GOTO :NewProxy
IF "%url%" EQU "@update" GOTO :Updater
IF "%url%" EQU "@external" GOTO :Aria2c
IF NOT DEFINED url GOTO :Link
CALL :Download "%url%"
ECHO.
ECHO.
GOTO :Link
:Download
youtube-dl.exe %format% %output% %archive% %server% %aria2c% %1 --verbose && CALL :Finish || CALL :Retry
ECHO.
ECHO.
CALL :Download %1
:Updater
youtube-dl.exe %server% --update --verbose && CALL :Finish || CALL :Retry
ECHO.
ECHO.
CALL :Updater
:Retry
IF %retry% EQU %attempt% GOTO :Finish
SET /A attempt=%attempt%+1
TIMEOUT /T 5
EXIT /B
:Finish
SET url=
GOTO :Link
:Audio
ECHO Audio Only
SET format=--format "bestaudio"
EXIT /B
:Best
ECHO Best Quality
SET format=--format "bestvideo+bestaudio/best"
EXIT /B
:1080p
ECHO Best Quality @1080p
SET format=--format "bestvideo[height<=1080]+bestaudio/best[height<=1080]"
EXIT /B
:2K
ECHO Best Quality @2K
SET format=--format "bestvideo[height<=1440]+bestaudio/best[height<=1440]"
EXIT /B
:480p
ECHO Best Quality @4K
SET format=--format "bestvideo[height<=2160]+bestaudio/best[height<=2160]"
EXIT /B
:NewFormat
SET url=
SET fm=
SET format=
CALL :Format
GOTO :Link
:NewFolder
SET url=
SET folder=
CALL :Folder
GOTO :Link
:NewProxy
SET url=
SET px=
CALL :Proxy
GOTO :Link
