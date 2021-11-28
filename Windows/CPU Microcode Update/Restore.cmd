@ECHO OFF
FOR /F "tokens=2 delims==" %%I IN ('wmic os get BuildNumber /value') DO (SET Backup=%%I)
COPY /Y "%~DP0%Backup%\mcupdate_AuthenticAMD.dll" %SystemRoot%\System32
COPY /Y "%~DP0%Backup%\mcupdate_GenuineIntel.dll" %SystemRoot%\System32
TIMEOUT /T 5
