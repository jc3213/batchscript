@echo off
net stop wuauserv
net stop cryptSvc
net stop bits
net stop msiserver
rd /q /s %SystemRoot%\SoftwareDistribution
rd /q /s %SystemRoot%\System32\catroot2
net start wuauserv
net start cryptSvc
net start bits
net start msiserver
timeout /t 5
