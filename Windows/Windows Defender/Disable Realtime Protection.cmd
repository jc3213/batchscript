@ECHO OFF
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /V "DisableAntiSpyware" /T "REG_DWORD" /D "0x00000001" /F
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /V "DisableRealtimeMonitoring" /T "REG_DWORD" /D "0x00000001" /F
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /V "DisableBehaviorMonitoring" /T "REG_DWORD" /D "0x00000001" /F
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /V "DisableScanOnRealtimeEnable" /T "REG_DWORD" /D "0x00000001" /F
TIMEOUT /T 5
