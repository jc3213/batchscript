@ECHO OFF
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /V "DisableAntiSpyware" /T "REG_DWORD" /D "0x00000001" /F
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Virus and threat protection" /V "UILockdown" /T "REG_DWORD" /D "0x00000001" /F
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray" /V "HideSystray" /T "REG_DWORD" /D "0x00000001" /F
REG DELETE "HKCR\*\shellex\ContextMenuHandlers\EPP" /VE /F
REG DELETE "HKCR\Drive\shellex\ContextMenuHandlers\EPP" /VE /F
REG DELETE "HKCR\Directory\shellex\ContextMenuHandlers\EPP" /VE /F
REG DELETE "HKCR\CLSID\{09A47860-11B0-4DA5-AFA5-26D86198A780}\InprocServer32" /VE /F
TIMEOUT /T 5
