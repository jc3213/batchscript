@ECHO OFF
SCHTASKS /Change /DISABLE /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
SCHTASKS /Change /DISABLE /TN "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /V "AllowTelemetry" /T "REG_DWORD" /D "0x00000000" /F
SC STOP "DiagTrack"
SC CONFIG "DiagTrack" START=DISABLED
SC STOP "DPS"
SC CONFIG "DPS" START=DISABLED
TIMEOUT /T 5
