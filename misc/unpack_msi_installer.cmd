@ECHO OFF
PUSHD %~DP0
IF EXIST 7z.exe GOTO :File
FOR /F "tokens=1,2*" %%I IN ('REG QUERY HKLM\Software\7-Zip /V Path') DO (
    IF "%%I"=="Path" PUSHD %%K
)
IF NOT EXIST 7z.exe GOTO :Error
:File
IF "%1"=="" GOTO :Input
GOTO :Unpack
:Input
SET /P File=Select iTunes Installer: 
IF NOT EXIST "%File%" GOTO :Input
CALL :File %File%
:Unpack
MSIEXEC /A "%1" /Q TARGETDIR=%~DP1_unpacked
:Error
EXIT
