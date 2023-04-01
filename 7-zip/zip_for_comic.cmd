@ECHO OFF
PUSHD %~DP0
SET Zip=%ProgramFiles%\7-Zip\7z.exe
IF EXIST "%Zip%" GOTO :Main
SET Zip=%CD%\bin\7za.exe
IF NOT EXIST "%Zip%" GOTO :Exit
:Main
ECHO ==================================================================
ECHO Remove original files or temporary files? (Y/y)
ECHO ==================================================================
SET /P Yes=^> 
ECHO.
ECHO.
FOR %%I IN (%*) DO (CALL :Core %%I)
GOTO :Exit
:Core
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
EXIT
