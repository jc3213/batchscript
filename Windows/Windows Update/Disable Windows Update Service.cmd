@echo off
sc stop "wuauserv"
sc config "wuauserv" start=disabled
sc stop "UsoSvc"
sc config "UsoSvc" start=disabled
timeout /t 5
