@ECHO OFF
FOR /F "USEBACKQ SKIP=2 TOKENS=1,2 DELIMS==: " %%I IN ("%Public%\Documents\Tencent\QQ\UserDataInfo.ini") DO (IF %%~I EQU UserDataSavePathType SET Mode=%%~J)
IF %Mode% EQU 1 GOTO :Document
GOTO :End
:Document
FOR /D %%I IN ("%UserProfile%\Documents\Tencent Files\*") DO (CALL :Process "%%I")
:End
TIMEOUT /T 5
EXIT
:Process
IF "%~N1" EQU "ALL Users" EXIT /B
RD /S /Q "%~1\Audio" 2>NUL
RD /S /Q "%~1\FileRecv" 2>NUL
RD /S /Q "%~1\Image" 2>NUL
RD /S /Q "%~1\Video" 2>NUL
MKLINK /D "%~1\Audio" "R:\Temp"
MKLINK /D "%~1\FileRecv" "R:\Temp"
MKLINK /D "%~1\Image" "R:\Temp"
MKLINK /D "%~1\Video" "R:\Temp"
