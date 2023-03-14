@ECHO OFF
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /V "MaintenanceDisabled" /F
TIMEOUT /T 5