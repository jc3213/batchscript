@ECHO OFF
PUSHD %~DP0
SETLOCAL EnableDelayedExpansion
:Environment
IF NOT EXIST youtube-dl.conf GOTO :Wizard
:Config
FOR /F "usebackq tokens=1-2 delims==" %%I IN ("youtube-dl.conf") DO (
    IF "%%I"=="format" CALL :%%J 2>NUL
    IF "%%I"=="folder" SET folder=%%J
    IF "%%I"=="proxy" SET proxy=%%J
    IF "%%I"=="history" SET history=%%J
    IF "%%I"=="retry" SET retry=%%J
)
:Wizard
IF NOT DEFINED format CALL :Format
IF NOT DEFINED folder (CALL :Select) ELSE (CALL :Folder)
CALL :Bypass
IF DEFINED history SET archive=--download-archive "!history!"
IF NOT DEFINED retry SET retry=5
:URL
ECHO.
ECHO.
SET attempt=0
SET /P url=Video URL: 
IF "%url%"=="@format" GOTO :NewFormat
IF "%url%"=="@folder" GOTO :NewFolder
IF "%url%"=="@proxy" GOTO :NewProxy
IF "%url%"=="@update" GOTO :Updater
IF EXIST "%url%" FOR /F "usebackq tokens=* delims=" %%I IN ("%url%") DO (CALL :Download "%%I")
CALL :Download "%url%"
:Format
ECHO.
ECHO.
ECHO ========================================================================================
ECHO 1. Audio Only
ECHO 2. Best Quality
ECHO 3. Best Quality @1080p
ECHO 4. Best Quality @720p
ECHO 5. Best Quality @480p
ECHO ========================================================================================
SET /P form=Select Format: 
IF "%form%"=="1" CALL :Audio
IF "%form%"=="2" CALL :Best
IF "%form%"=="3" CALL :1080p
IF "%form%"=="4" CALL :720p
IF "%form%"=="5" CALL :480p
IF DEFINED format EXIT /B
GOTO :Format
:Select
ECHO.
ECHO.
ECHO ========================================================================================
ECHO %~DP0Download (Default)
ECHO ========================================================================================
SET /P folder=Select Folder: 
IF NOT DEFINED folder SET folder=%~DP0Download
:Folder
ECHO.
ECHO.
ECHO Download Folder: %folder%
SET output=-o "!folder!\%%(title)s.%%(ext)s"
EXIT /B
:Bypass
IF NOT DEFINED proxy GOTO :Server
ECHO.
ECHO.
ECHO ========================================================================================
ECHO 2. Other
ECHO 1. Yes ^(%proxy%^)
ECHO 0. No
ECHO ========================================================================================
SET /P pass=Use Proxy Server:
IF "%pass%"=="2" GOTO :Server
IF "%pass%"=="1" GOTO :Proxy
IF "%pass%"=="0" EXIT /B
GOTO :Bypass
:Server
ECHO.
ECHO.
ECHO ========================================================================================
ECHO Keep EMPTY if you don't use a proxy
ECHO 127.0.0.1:1080 (Sample)
ECHO ========================================================================================
SET proxy=
SET /P proxy=Proxy Server: 
IF NOT DEFINED proxy GOTO :Server
:Proxy
SET server=--proxy "!proxy!"
EXIT /B
:Download
ECHO.
ECHO.
bin\youtube-dl.exe %format% %output% %archive% %server% %1 --verbose && CALL :Finish || CALL :Retry
CALL :Download %1
:Updater
ECHO.
ECHO.
bin\youtube-dl.exe %server% --update --verbose && CALL :Finish || CALL :Retry
CALL :Updater
:Retry
IF "%retry%"=="%attempt%" GOTO :Finish
SET /A attempt=%attempt%+1
TIMEOUT /T 5
EXIT /B
:Finish
SET url=
GOTO :URL
:Audio
ECHO Format Option: Audio Only
SET format=-f "bestaudio"
EXIT /B
:Best
ECHO Format Option: Best Quality
SET format=-f "bestvideo+bestaudio/best"
EXIT /B
:1080p
ECHO Format Option: Best Quality @1080p
SET format=-f "bestvideo[height=1080]+bestaudio/best[height=1080]"
EXIT /B
:720p
ECHO Format Option: Best Quality @720p
SET format=-f "bestvideo[height=720]+bestaudio/best[height=720]"
EXIT /B
:480p
ECHO Format Option: Best Quality @480p
SET format=-f "bestvideo[height=480]+bestaudio/best[height=480]"
EXIT /B
:NewFormat
SET url=
SET form=
SET format=
CALL :Format
GOTO :URL
:NewFolder
SET url=
SET dir=
CALL :Folder
GOTO :URL
:NewProxy
SET url=
SET pass=
CALL :Bypass
GOTO :URL
