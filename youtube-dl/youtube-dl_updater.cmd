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
CALL :Proxy
CALL :Space
CALL :Updater
PAUSE
GOTO :Wizard
::
:Proxy
CALL :Warn Proxy
SET /P option_p=Use Proxy Server: 
IF "%option_p%"=="1" GOTO :Server
IF "%option_p%"=="0" EXIT /B
GOTO :Proxy
:Server
CALL :Warn Server
IF DEFINED proxy (ECHO Proxy Server: %proxy%) ELSE (SET /P proxy=Proxy Server: )
IF DEFINED proxy SET server=--proxy "!proxy!"
EXIT /B
::
:Updater
bin\youtube-dl.exe %server% --update --verbose
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
:Warn_Proxy
ECHO 1. Yes
ECHO 0. No
EXIT /B
:Warn_Server
ECHO Keep EMPTY if you don't use a proxy
ECHO 127.0.0.1:1080 (Sample)
EXIT /B
