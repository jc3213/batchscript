@echo off
schtasks /change /disable /tn "\Microsoft\Windows\Defrag\ScheduledDefrag"
timeout /t 5