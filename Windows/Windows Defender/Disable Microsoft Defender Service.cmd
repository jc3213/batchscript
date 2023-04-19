@echo off
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WinDefend" /v "Start" /T "REG_DWORD" /D "0x00000004" /f
echo Reboot is required for changes to take effect
tmeout /t 5
