@echo off
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Edge" /V "UserDataDir" /F
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Edge" /V "DiskCacheDir" /F
timeout /t 5
