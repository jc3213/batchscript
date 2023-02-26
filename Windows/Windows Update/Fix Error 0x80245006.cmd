@ECHO OFF
NET STOP wuauserv
NET STOP cryptSvc
NET STOP bits
NET STOP msiserver
RD /Q /S %SystemRoot%\SoftwareDistribution
RD /Q /S %SystemRoot%\System32\catroot2
NET START wuauserv
NET START cryptSvc
NET START bits
NET START msiserver
TIMEOUT /T 5
