@ECHO OFF
PUSHD %~DP0
SETLOCAL EnableDelayedExpansion
:Environment
IF NOT EXIST youtube-dl.conf GOTO :Wizard
:Config
FOR /F "usebackq tokens=1-2 delims==" %%I IN ("youtube-dl.conf") DO (
    IF "%%I"=="proxy" SET proxy=%%J
)
:Wizard
CALL :Bypass
CALL :Space
CALL :Updater
PAUSE
GOTO :Wizard
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
:Updater
SET attempt=0
IF NOT DEFINED retry SET retry=5
:Process
IF "%retry%"=="%attempt%" (
ECHO "%retry%"=="%attempt%"
    PAUSE
    GOTO :Wizard
)
bin\youtube-dl.exe %server% --update --verbose || (
    TIMEOUT /T 5
    SET /A attempt=%attempt%+1
    GOTO :Process
)
EXIT /B
:Space
ECHO.
ECHO.
EXIT /B
:Warn
CALL :Space
ECHO ========================================================================================
CALL :Warn_%1
ECHO ========================================================================================
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
