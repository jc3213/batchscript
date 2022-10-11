@ECHO OFF
PUSHD %~DP0
SETLOCAL EnableDelayedExpansion
:Environment
IF NOT EXIST youtube-dl.conf GOTO :Wizard
:Config
FOR /F "tokens=1,2 delims==" %%I IN ('type youtube-dl.conf') DO (
    IF %%I EQU format CALL :%%J 2>NUL
    IF %%I EQU folder SET folder=%%J
    IF %%I EQU proxy SET proxy=%%J
    IF %%I EQU history SET history=%%J
    IF %%I EQU retry SET retry=%%J
)
:Wizard
IF NOT DEFINED format CALL :Format
IF NOT DEFINED folder (CALL :Select) ELSE (CALL :Folder)
CALL :Bypass
IF DEFINED history SET archive=--download-archive "!history!"
IF NOT DEFINED retry SET retry=5
PUSHD %~DP0bin
:Aria2c
IF NOT EXIST aria2c.exe GOTO :Link
ECHO Use aria2c download manager?
ECHO ========================================================================================
ECHO 0. No
ECHO 1. Yes
ECHO ========================================================================================
SET /P external=^> 
IF %external% EQU 1 SET aria2c=--external-downloader "aria2c" --external-downloader-args "-c -j 10 -x 10 -s 10 -k 1M"
:Link
ECHO.
ECHO.
SET attempt=0
SET /P url=Video URL: 
IF "%url%" EQU "@format" GOTO :NewFormat
IF "%url%" EQU "@folder" GOTO :NewFolder
IF "%url%" EQU "@proxy" GOTO :NewProxy
IF "%url%" EQU "@update" GOTO :Updater
CALL :Download "%url%"
GOTO :Link
:Format
ECHO Set video format
ECHO ========================================================================================
ECHO 1. Audio Only
ECHO 2. Best Quality
ECHO 3. Best Quality @1080p
ECHO 4. Best Quality @720p
ECHO 5. Best Quality @480p
ECHO ========================================================================================
SET /P form=^> 
ECHO.
ECHO.
IF %form% EQU 1 CALL :Audio
IF %form% EQU 2 CALL :Best
IF %form% EQU 3 CALL :1080p
IF %form% EQU 4 CALL :720p
IF %form% EQU 5 CALL :480p
IF DEFINED format EXIT /B
GOTO :Format
:Select
ECHO Set download folder
ECHO ========================================================================================
ECHO %~DP0Download (Default)
ECHO ========================================================================================
SET /P folder=^> 
IF NOT DEFINED folder SET folder=%~DP0Download
:Folder
ECHO.
ECHO.
ECHO Download Folder: %folder%
SET output=--output "!folder!\%%(title)s.%%(ext)s"
ECHO.
ECHO.
EXIT /B
:Bypass
IF NOT DEFINED proxy GOTO :Server
ECHO Use proxy server?
ECHO ========================================================================================
ECHO 0. No
ECHO 1. Yes (%proxy%)
ECHO 2. Other
ECHO ========================================================================================
SET /P pass=^> 
ECHO.
ECHO.
IF %pass% EQU 2 GOTO :Server
IF %pass% EQU 1 GOTO :Proxy
IF %pass% EQU 0 EXIT /B
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
:Proxy
IF DEFINED proxy SET server=--proxy "!proxy!"
EXIT /B
:Download
ECHO.
ECHO.
youtube-dl.exe %format% %output% %archive% %server% %aria2c% %1 --verbose && CALL :Finish || CALL :Retry
CALL :Download %1
:Updater
ECHO.
ECHO.
youtube-dl.exe %server% --update --verbose && CALL :Finish || CALL :Retry
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
SET format=--format "bestvideo[height=1080]+bestaudio/best[height=1080]"
EXIT /B
:720p
ECHO Best Quality @720p
SET format=--format "bestvideo[height=720]+bestaudio/best[height=720]"
EXIT /B
:480p
ECHO Best Quality @480p
SET format=--format "bestvideo[height=480]+bestaudio/best[height=480]"
EXIT /B
:NewFormat
SET url=
SET form=
SET format=
CALL :Format
GOTO :Link
:NewFolder
SET url=
SET dir=
CALL :Folder
GOTO :Link
:NewProxy
SET url=
SET pass=
CALL :Bypass
GOTO :Link
