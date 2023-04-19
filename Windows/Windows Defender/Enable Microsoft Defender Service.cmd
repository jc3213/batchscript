@echo off
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WinDefend" /v "Start" /t "REG_DWORD" /d "0x00000002" /f
echo Reboot is required for changes to take effect
tmeout /t 5
