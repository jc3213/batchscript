@ECHO OFF
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /V "ExcludeWUDriversInQualityUpdate" /T "REG_DWORD" /D "0x00000001" /F
TIMEOUT /T 5
