@ECHO OFF
REG DELETE "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /V "NoAutoUpdate" /F
TIMEOUT /T 5
