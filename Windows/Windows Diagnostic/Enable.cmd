@ECHO OFF
SCHTASKS /Change /ENABLE /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
SCHTASKS /Change /ENABLE /TN "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
REG DELETE "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /V "AllowTelemetry" /F
SC CONFIG "DiagTrack" START=AUTO
SC START "DiagTrack"
SC CONFIG "DPS" START=AUTO
SC START "DPS"
TIMEOUT /T 5
