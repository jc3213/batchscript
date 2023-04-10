@ECHO OFF
PUSHD %~DP0
IF EXIST %1 GOTO :Unpack
:File
SET /P File=Select .MSI Installer: 
IF NOT EXIST "%File%" GOTO :File
CALL :Unpack "%File%"
:Unpack
MSIEXEC /A "%1" /Q TARGETDIR=%~DP1_unpacked
ECHO.
ECHO.
TIMEOUT -T 5
EXIT
