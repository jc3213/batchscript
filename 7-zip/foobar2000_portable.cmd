@ECHO OFF
PUSHD %~DP0
FOR /F "tokens=1,2*" %%I IN ('REG QUERY HKLM\Software\7-Zip /V Path') DO (IF "%%I"=="Path" SET Zip=%%K7z.exe)
"%Zip%" x %1 -y -x!$PLUGINSDIR -x!$R0 -x!uninstall.exe -o"%~DPN1"
TYPE NUL > "%~DPN1\portable_mode_enabled"
ECHO.
ECHO.
ECHO Portable location %~DPN1
ECHO.
ECHO.
TIMEOUT -T 5
EXIT
