@echo off
sc config "SysMain" start=auto
sc start "SysMain"
timeout /t 5
