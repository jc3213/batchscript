@ECHO OFF
REG ADD "HKLM\SYSTEM\CurrentControlSet\Services\WinDefend" /V "Start" /T "REG_DWORD" /D "0x00000004" /F
ECHO Reboot is required for changes to take effect
TIMEOUT /T 5
