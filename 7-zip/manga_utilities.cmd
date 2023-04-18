@ECHO OFF
PUSHD %~DP0
FOR /F "tokens=1,2*" %%I IN ('REG QUERY HKLM\Software\7-Zip /V Path') DO (IF "%%I"=="Path" SET Zip=%%K7z.exe)
ECHO ==================================================================
ECHO Remove original files or temporary files? (Y/y)
ECHO ==================================================================
SET /P Yes=^> 
FOR %%I IN (%*) DO (CALL :Check %%I)
GOTO :Exit
:Check
CD /D %1 2>NUL
IF %ErrorLevel% EQU 0 GOTO :NewPack
:Repack
ECHO a|"%Zip%" x %1 -o"%~DPN1"
"%Zip%" a "%~DPN1.zip" "%~DPN1\*"
IF /I [%Yes%] NEQ [y] EXIT /B
RD /S /Q "%~DPN1"
IF /I %~X1 NEQ .zip DEL %1 /S /Q
EXIT /B
:NewPack
"%Zip%" a "%~DPNX1.zip" "*"
IF /I [%Yes%] NEQ [y] EXIT /B
CD..
RD /S /Q "%~1"
EXIT /B
:Exit
TIMEOUT -T 5
