@ECHO OFF
%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe -Command "Compress-Archive -Path '%SystemRoot%\System32\mcupdate_AuthenticAMD.dll','%SystemRoot%\System32\mcupdate_GenuineIntel.dll' -DestinationPath '%~DP0Backup.zip'"
%SystemRoot%\System32\cmd.exe /C TAKEOWN /F "%SystemRoot%\System32\mcupdate_AuthenticAMD.dll" && ICACLS "%SystemRoot%\System32\mcupdate_AuthenticAMD.dll" /grant Administrators:F
%SystemRoot%\System32\cmd.exe /C TAKEOWN /F "%SystemRoot%\System32\mcupdate_GenuineIntel.dll" && ICACLS "%SystemRoot%\System32\mcupdate_GenuineIntel.dll" /grant Administrators:F
DEL "%SystemRoot%\System32\mcupdate_AuthenticAMD.dll" "%SystemRoot%\System32\mcupdate_GenuineIntel.dll" /F /Q
TIMEOUT /T 5
