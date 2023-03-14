@ECHO OFF
SCHTASKS /Change /DISABLE /TN "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan"
TIMEOUT /T 5
