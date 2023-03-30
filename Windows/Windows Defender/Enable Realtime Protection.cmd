@ECHO OFF
REG DELETE "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /V "DisableAntiSpyware" /F
REG DELETE "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /F
TIMEOUT /T 5
