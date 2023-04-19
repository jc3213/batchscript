@echo off
schtasks /change /enable /tn "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan"
tmeout /t 5
