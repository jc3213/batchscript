@ECHO OFF
PUSHD %~DP0
FOR /F "tokens=2 delims==" %%I IN ('wmic os get Version /value') DO (SET Backup=%%I)
COPY /Y %Backup%\mcupdate_AuthenticAMD.dll %SystemRoot%\System32
COPY /Y %Backup%\mcupdate_GenuineIntel.dll %SystemRoot%\System32
TIMEOUT /T 5
