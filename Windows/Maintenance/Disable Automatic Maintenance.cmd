@ECHO OFF
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /V "MaintenanceDisabled" /T "REG_DWORD" /D "0x00000001" /F
TIMEOUT /T 5