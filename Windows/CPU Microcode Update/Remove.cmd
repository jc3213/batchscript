@ECHO OFF
PUSHD %~DP0
MD Backup >NUL
CALL :Process %SystemRoot%\System32\mcupdate_AuthenticAMD.dll
CALL :Process %SystemRoot%\System32\mcupdate_GenuineIntel.dll
TIMEOUT /T 5
EXIT
:Process
%SystemRoot%\System32\cmd.exe /C TAKEOWN /F %1 && ICACLS %1 /grant Administrators:F
COPY /Y %1 Backup
DEL %1 /F /Q
EXIT /B
