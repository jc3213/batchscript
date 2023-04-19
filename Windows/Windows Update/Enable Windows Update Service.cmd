@echo off
sc config "wuauserv" start=demand
sc start "wuauserv"
sc config "UsoSvc" start=delayed-auto
sc start "UsoSvc"
timeout /t 5
