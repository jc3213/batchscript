@ECHO OFF
IF NOT EXIST %1 EXIT
SETLOCAL EnableDelayedExpansion
PUSHD %~DPN1
SET Name=%~DP0%~N1
CALL :ListFiles /u
:ListFiles
FOR /F "TOKENS=*" %%A IN (
    'DIR /B /A-D'
) DO (
    CALL :FileList "%%A"
)
TAR -caf "%Name%.zip" %File%
PAUSE
EXIT
:FileList
SET File=%File% %1
EXIT /B
