@ECHO OFF
PUSHD %~DP0
FOR /F "tokens=1,2*" %%I IN ('REG QUERY HKLM\Software\7-Zip /V Path') DO (IF "%%I"=="Path" SET Zip=%%K7z.exe)
IF NOT EXIST "%Zip%" GOTO :Exit
ECHO ==================================================================
ECHO Remove original files or temporary files? (Y/y)
ECHO ==================================================================
SET /P Yes=^> 
ECHO.
ECHO.
FOR %%I IN (%*) DO (CALL :Check %%I)
GOTO :Exit
:Check
CD /D %1 2>NUL
IF %ErrorLevel% EQU 0 GOTO :NewPack
:Repack
ECHO a|"%Zip%" x %1 -o"%~DPN1"
"%Zip%" a "%~DPN1.zip" "%~DPN1\*"
IF %Yes% EQU Y GOTO :ReClear
IF %Yes% EQU y GOTO :ReClear
EXIT /B
:ReClear
RD /S /Q "%~DPN1"
EXIT /B
:NewPack
"%Zip%" a "%~DPNX1.zip" "*"
IF %Yes% EQU Y GOTO :NewClear
IF %Yes% EQU y GOTO :NewClear
EXIT /B
:NewClear
CD..
RD /S /Q "%~1"
EXIT /B
:Exit
TIMEOUT -T 5
