@ECHO OFF
PUSHD %~DP0
SETLOCAL EnableDelayedExpansion
:Environment
IF NOT EXIST youtube-dl.conf GOTO :Wizard
:Config
FOR /F "usebackq tokens=1-2 delims==" %%I IN ("youtube-dl.conf") DO (
    IF "%%I"=="format" CALL :%%J 2>NUL
    IF "%%I"=="dir" SET dir=%%J
    IF "%%I"=="proxy" SET proxy=%%J
    IF "%%I"=="history" set history=%%J
    IF "%%I"=="retry" set retry=%%J
)
IF NOT DEFINED retry SET retry=5
:Wizard
CALL :Format
CALL :Folder
CALL :Bypass
CALL :Archive
GOTO :URL
::
:Format
IF DEFINED format EXIT /B
CALL :Warn Format
SET /P form=Select Format: 
IF "%form%"=="1" CALL :Audio
IF "%form%"=="2" CALL :Best
IF "%form%"=="3" CALL :1080p
IF "%form%"=="4" CALL :720p
IF "%form%"=="5" CALL :480p
IF DEFINED format EXIT /B
GOTO :Format
::
:Folder
CALL :Warn Folder
IF DEFINED dir (
    ECHO Download Folder: %dir%
) ELSE (
    SET /P dir=Select Folder: 
)
IF NOT DEFINED dir (
    ECHO Download Folder: %~DP0download
    SET dir=download
)
SET output=-o "!dir!\%%(title)s.%%(ext)s"
EXIT /B
::
:Bypass
IF DEFINED proxy (
    CALL :Warn Bypass
    SET /P pass=Use Proxy Server:
) ELSE (
    GOTO :Server
)
IF "%pass%"=="2" GOTO :Server
IF "%pass%"=="1" GOTO :Proxy
IF "%pass%"=="0" EXIT /B
GOTO :Bypass
:Server
SET proxy=
SET /P proxy=Proxy Server: 
IF DEFINED proxy GOTO :Proxy
GOTO :Server
:Proxy
SET server=--proxy "!proxy!"
EXIT /B
::
:Archive
IF DEFINED history SET archive=--download-archive "!history!"
EXIT /B
::
:URL
CALL :Space
SET attempt=0
SET /P url=Video URL: 
IF "%url%"=="@format" CALL :Clear Format
IF "%url%"=="@folder" CALL :Clear Folder
IF "%url%"=="@proxy" CALL :Clear Bypass
IF "%url%"=="@update" CALL :Updater
IF EXIST "%url%" FOR /F "usebackq tokens=* delims=" %%I IN ("%url%") DO (CALL :Download "%%I")
ECHO "%url%" | FIND "https://" && CALL :Download "%url%"
GOTO :URL
:Download
bin\youtube-dl.exe %format% %output% %archive% %server% %1 --verbose && CALL :Finish || CALL :Retry
CALL :Download %1
:Updater
bin\youtube-dl.exe %server% --update --verbose && CALL :Finish || CALL :Retry
CALL :Updater
:Retry
IF "%retry%"=="%attempt%" GOTO :URL
TIMEOUT /T 5
SET /A attempt=%attempt%+1
EXIT /B
:Finish
SET url=
GOTO :URL
::
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
::
:Space
ECHO.
ECHO.
EXIT /B
::
:Warn
CALL :Space
ECHO ========================================================================================
CALL :Warn_%1
ECHO ========================================================================================
EXIT /B
:Clear
SET url=
CALL :Clear_%1
CALL :%1
EXIT /B
:Warn_Format
ECHO 1. Audio Only
ECHO 2. Best Quality
ECHO 3. Best Quality @1080p
ECHO 4. Best Quality @720p
ECHO 5. Best Quality @480p
EXIT /B
:Clear_Format
SET form=
SET format=
EXIT /B
:Warn_Folder
ECHO %~DP0download (Default)
EXIT /B
:Clear_Folder
SET dir=
EXIT /B
:Warn_Bypass
ECHO 2. Other
ECHO 1. Yes ^(%proxy%^)
ECHO 0. No
EXIT /B
:Warn_Server
ECHO Keep EMPTY if you don't use a proxy
ECHO 127.0.0.1:1080 (Sample)
EXIT /B
:Clear_Bypass
SET pass=
EXIT /B
