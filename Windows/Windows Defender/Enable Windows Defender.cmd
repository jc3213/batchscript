@ECHO OFF
REG DELETE "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /V "DisableAntiSpyware" /F
REG DELETE "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /F
REG DELETE "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Virus and threat protection" /V "UILockdown" /F
REG DELETE "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray" /V "HideSystray" /F
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /V "SecurityHealth" /T "REG_BINARY" /D "060000000000000000000000" /F
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /V "SecurityHealth" /T "REG_EXPAND_SZ" /D "%%windir%%\system32\SecurityHealthSystray.exe" /F
REG ADD "HKCR\*\shellex\ContextMenuHandlers\EPP" /VE /T "REG_SZ" /D "{09A47860-11B0-4DA5-AFA5-26D86198A780}" /F
REG ADD "HKCR\Drive\shellex\ContextMenuHandlers\EPP" /VE /T "REG_SZ" /D "{09A47860-11B0-4DA5-AFA5-26D86198A780}" /F
REG ADD "HKCR\Directory\shellex\ContextMenuHandlers\EPP" /VE /T "REG_SZ" /D "{09A47860-11B0-4DA5-AFA5-26D86198A780}" /F
REG ADD "HKCR\CLSID\{09A47860-11B0-4DA5-AFA5-26D86198A780}\InprocServer32" /VE /T "REG_SZ" /D "%ProgramFiles%\Windows Defender\shellext.dll" /F
TIMEOUT /T 5
