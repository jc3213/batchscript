@echo off
for /f %%a in ('wmic logicaldisk where "VolumeName='RAMDISK'" get Caption ^| find ":"') do (set Ramdisk=%%a\Temp)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "UserDataDir"  /t "REG_SZ" /d "%UserProfile%\Documents\EdgeUserData" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "DiskCacheDir" /t "REG_SZ" /d "%Ramdisk%" /f
timeout /t 5
