@ECHO OFF
PUSHD %~DP0
COPY /Y Backup\mcupdate_AuthenticAMD.dll %SystemRoot%\System32
COPY /Y Backup\mcupdate_GenuineIntel.dll %SystemRoot%\System32
TIMEOUT /T 5
