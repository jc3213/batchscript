@ECHO OFF
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "MultiTaskingAltTabFilter" /T "REG_DWORD" /D "0x00000001" /F
TIMEOUT /T 5
