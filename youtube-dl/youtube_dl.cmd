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
)
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
SET /P option_f=Select Format: 
IF "%option_f%"=="1" CALL :Audio
IF "%option_f%"=="2" CALL :Best
IF "%option_f%"=="3" CALL :1080p
IF "%option_f%"=="4" CALL :720p
IF "%option_f%"=="5" CALL :480p
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
:Server
SET /P proxy=Proxy Server: 
IF DEFINED proxy (
    GOTO :Proxy
) ELSE (
    GOTO :Server
)
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
SET /P url=Video URL: 
SET Attempt=0
SET Retry=5
CALL :Space
IF EXIST "%url%" (
    FOR /F "usebackq tokens=* delims=" %%I IN ("%url%") DO (CALL :Process "%%I")
) ELSE (
    CALL :Process "%url%"
)
GOTO :URL
::
:Process
IF "%Retry%"=="%Attempt%" GOTO :URL
SET /A Attempt=%Attempt%+1
ECHO %Attempt%
bin\youtube-dl.exe %format% %output% %archive% %server% %1 -v || (
    TIMEOUT /T 5
    GOTO :Process
)
EXIT /B
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
:Warn_Format
ECHO 1. Audio Only
ECHO 2. Best Quality
ECHO 3. Best Quality @1080p
ECHO 4. Best Quality @720p
ECHO 5. Best Quality @480p
EXIT /B
:Warn_Folder
ECHO %~DP0download (Default)
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
