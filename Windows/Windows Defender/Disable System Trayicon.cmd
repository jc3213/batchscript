@ECHO OFF
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray" /V "HideSystray" /T "REG_DWORD" /D "0x00000001" /F
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /V "SecurityHealth" /T "REG_BINARY" /D "07000000CD54F699D161D900" /F
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /V "SecurityHealth" /F
TIMEOUT /T 5
