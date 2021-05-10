@ECHO OFF
PUSHD %~DP0
:File
IF "%1"=="" GOTO :Input
GOTO :Unpack
:Input
SET /P File=Select iTunes Installer: 
IF NOT EXIST "%File%" GOTO :Input
CALL :File %File%
:Unpack
ECHO Unpacking MSI installer %~NX1 . . .
MSIEXEC /A "%1" /Q TARGETDIR=%~DP1_unpacked
ECHO.
ECHO MSI installer %~NX1 has been unpacked
ECHO.
PAUSE
EXIT
