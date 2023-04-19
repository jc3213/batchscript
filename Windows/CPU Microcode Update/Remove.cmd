@echo off
%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe -Command "Compress-Archive -Force -Path '%SystemRoot%\System32\mcupdate_AuthenticAMD.dll','%SystemRoot%\System32\mcupdate_GenuineIntel.dll' -DestinationPath '%~DP0Backup.zip'"
%SystemRoot%\System32\cmd.exe /c takeown /f %SystemRoot%\System32\mcupdate_AuthenticAMD.dll && icacls %SystemRoot%\System32\mcupdate_AuthenticAMD.dll /grant Administrators:F
%SystemRoot%\System32\cmd.exe /c takeown /f %SystemRoot%\System32\mcupdate_GenuineIntel.dll && icacls %SystemRoot%\System32\mcupdate_GenuineIntel.dll /grant Administrators:F
del "%SystemRoot%\System32\mcupdate_AuthenticAMD.dll" "%SystemRoot%\System32\mcupdate_GenuineIntel.dll" /f /q
timeout /t 5
