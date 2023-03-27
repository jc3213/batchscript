@ECHO OFF
PUSHD %~DP0
IF EXIST "%ProgramFiles%\7-Zip\7z.exe" SET Zip=%ProgramFiles%\7-Zip\7z.exe
IF DEFINED Zip GOTO :Main
IF EXIST "%CD%\bin\7za.exe" SET Zip=%CD%\bin\7za.exe
IF NOT DEFINED Zip GOTO :Exit
:Main
ECHO ==================================================================
ECHO Remove original files or temporary files? (Y/N)
ECHO ==================================================================
SET /P Yes=^> 
FOR %%I IN (%*) DO (CALL :Core %%I)
GOTO :Exit
:Core
IF NOT EXIST "%1" GOTO :Exit
CD /D %1
IF %ErrorLevel% EQU 0 GOTO :NewPack
:Repack
ECHO a|"%Zip%" x %1 -o"%~DPN1"
"%Zip%" a "%~DPN1.zip" "%~DPN1\*"
IF %Yes% EQU Y GOTO :ReZip
IF %Yes% EQU y GOTO :ReZip
EXIT /B
:ReZip
RD /S /Q "%~DPN1"
EXIT /B
:NewPack
"%Zip%" a "%~DPNX1.zip" "*"
IF %Yes% EQU Y GOTO :NewZip
IF %Yes% EQU y GOTO :NewZip
EXIT /B
:NewZip
CD..
RD /S /Q "%~1"
EXIT /B
:Exit
TIMEOUT -T 5
EXIT
