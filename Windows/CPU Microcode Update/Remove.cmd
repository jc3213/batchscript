@ECHO OFF
PUSHD %~DP0
FOR /F "tokens=2 delims==" %%I IN ('wmic os get Version /value') DO (SET Backup=%%I)
MD %Backup% 2>NUL
CALL :Process %SystemRoot%\System32\mcupdate_AuthenticAMD.dll
CALL :Process %SystemRoot%\System32\mcupdate_GenuineIntel.dll
GOTO :Exit
:Process
%SystemRoot%\System32\cmd.exe /C TAKEOWN /F %1 && ICACLS %1 /grant Administrators:F
COPY /Y %1 %Backup%
DEL %1 /F /Q
EXIT /B
:Exit
TIMEOUT /T 5