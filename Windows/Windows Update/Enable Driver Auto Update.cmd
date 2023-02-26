@ECHO OFF
REG DELETE "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /V "ExcludeWUDriversInQualityUpdate" /F
TIMEOUT /T 5
