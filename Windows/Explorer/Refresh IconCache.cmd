@echo off
taskkill /f /im "explorer.exe"
cd /d %LocalAppData%\Microsoft\Windows\Explorer
for %%a in (iconcache_*.db thumbcache_*.db) do (
    takeown /f %%a
    icacls %%a /grant Administrators:F
    attrib -h -s -r %%a
    del /f /q /a %%a
)
start "" "explorer.exe"
timeout /t 5
