@ECHO OFF
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "MultiTaskingAltTabFilter" /T "REG_DWORD" /D "0x00000003" /F
TIMEOUT /T 5
