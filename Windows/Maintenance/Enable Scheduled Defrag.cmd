@echo off
schtasks /change /enable /tn "\Microsoft\Windows\Defrag\ScheduledDefrag"
timeout /t 5