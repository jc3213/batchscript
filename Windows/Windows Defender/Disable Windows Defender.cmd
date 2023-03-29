@ECHO OFF
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /V "DisableAntiSpyware" /T "REG_DWORD" /D "0x00000001" /F
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /V "DisableRealtimeMonitoring" /T "REG_DWORD" /D "0x00000001" /F
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /V "DisableBehaviorMonitoring" /T "REG_DWORD" /D "0x00000001" /F
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /V "DisableScanOnRealtimeEnable" /T "REG_DWORD" /D "0x00000001" /F
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Virus and threat protection" /V "UILockdown" /T "REG_DWORD" /D "0x00000001" /F
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray" /V "HideSystray" /T "REG_DWORD" /D "0x00000001" /F
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /V "SecurityHealth" /T "REG_BINARY" /D "07000000CD54F699D161D900" /F
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /V "SecurityHealth" /F
REG DELETE "HKCR\*\shellex\ContextMenuHandlers\EPP" /VE /F
REG DELETE "HKCR\Drive\shellex\ContextMenuHandlers\EPP" /VE /F
REG DELETE "HKCR\Directory\shellex\ContextMenuHandlers\EPP" /VE /F
REG DELETE "HKCR\CLSID\{09A47860-11B0-4DA5-AFA5-26D86198A780}\InprocServer32" /VE /F
TIMEOUT /T 5
