@ECHO OFF
REG DELETE "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "MultiTaskingAltTabFilter"
TIMEOUT /T 5