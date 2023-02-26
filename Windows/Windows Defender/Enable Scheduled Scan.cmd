@ECHO OFF
SCHTASKS /Change /ENABLE /TN "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan"
TIMEOUT /T 5
