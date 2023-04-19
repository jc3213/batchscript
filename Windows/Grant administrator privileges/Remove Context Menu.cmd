@echo off
reg delete "HKCR\*\shell\runas" /f
reg delete "HKCR\Directory\shell\runas" /f
timeout /t 5