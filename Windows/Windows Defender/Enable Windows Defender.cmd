@ECHO OFF
REG DELETE "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /V "DisableAntiSpyware" /F
REG DELETE "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Virus and threat protection" /V "UILockdown" /F
REG DELETE "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray" /V "HideSystray" /F
REG ADD "HKCR\*\shellex\ContextMenuHandlers\EPP" /VE /T "REG_SZ" /D "{09A47860-11B0-4DA5-AFA5-26D86198A780}" /F
REG ADD "HKCR\Drive\shellex\ContextMenuHandlers\EPP" /VE /T "REG_SZ" /D "{09A47860-11B0-4DA5-AFA5-26D86198A780}" /F
REG ADD "HKCR\Directory\shellex\ContextMenuHandlers\EPP" /VE /T "REG_SZ" /D "{09A47860-11B0-4DA5-AFA5-26D86198A780}" /F
REG ADD "HKCR\CLSID\{09A47860-11B0-4DA5-AFA5-26D86198A780}\InprocServer32" /VE /T "REG_SZ" /D "%ProgramFiles%\Windows Defender\shellext.dll" /F
TIMEOUT /T 5
