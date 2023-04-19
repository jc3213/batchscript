@echo off
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray" /v "HideSystray" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "SecurityHealth" /t "REG_BINARY" /d "060000000000000000000000" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth" /t "REG_EXPAND_SZ" /d "%%windir%%\system32\SecurityHealthSystray.exe" /f
timeout /t 5
