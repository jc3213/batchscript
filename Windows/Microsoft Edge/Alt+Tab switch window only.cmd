@echo off
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "MultiTaskingAltTabFilter" /t "REG_DWORD" /d "0x00000003" /f
timeout /t 5
