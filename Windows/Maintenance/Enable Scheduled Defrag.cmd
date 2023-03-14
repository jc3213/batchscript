@ECHO OFF
SCHTASKS /Change /ENABLE /TN "\Microsoft\Windows\Defrag\ScheduledDefrag"
TIMEOUT /T 5