@ECHO OFF
PUSHD %~DP0
FOR /F "tokens=1,2*" %%I IN ('REG QUERY HKLM\Software\7-Zip /V Path') DO (IF "%%I"=="Path" SET Zip=%%K7z.exe)
IF NOT EXIST "%Zip%" GOTO :Exit
ECHO ==================================================================
ECHO Finding the latest Foobar2000 installer
ECHO %1
ECHO ==================================================================
ECHO.
ECHO.
ECHO ==================================================================
ECHO Extracting files from %~NX1
ECHO ==================================================================
ECHO.
ECHO.
"%Zip%" x %1 -x!$PLUGINSDIR -x!$R0 -x!uninstall.exe -o"%~DPN1"
ECHO.
ECHO.
ECHO ==================================================================
ECHO Makes Foobar2000 portable
ECHO ==================================================================
ECHO.
ECHO.
TYPE NUL > "%~DPN1\portable_mode_enabled"
ECHO ==================================================================
ECHO Foobar2000 Portable location:
ECHO %~DPN1
ECHO ==================================================================
ECHO.
ECHO.
TIMEOUT -T 5
EXIT
