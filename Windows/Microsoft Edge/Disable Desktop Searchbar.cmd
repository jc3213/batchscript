@echo off
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "WebWidgetAllowed"  /t "REG_DWORD" /d "0x00000000" /f
timeout /t 5
