@ECHO OFF
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /V "NoAutoUpdate" /T "REG_DWORD" /D "0x00000001" /F
TIMEOUT /T 5
