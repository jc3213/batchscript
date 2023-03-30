@ECHO OFF
REG DELETE "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray" /V "HideSystray" /F
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /V "SecurityHealth" /T "REG_BINARY" /D "060000000000000000000000" /F
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /V "SecurityHealth" /T "REG_EXPAND_SZ" /D "%%windir%%\system32\SecurityHealthSystray.exe" /F
TIMEOUT /T 5
