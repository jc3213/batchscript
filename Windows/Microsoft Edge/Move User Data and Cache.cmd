@ECHO OFF
FOR /F %%I in ('wmic logicaldisk where "VolumeName='RAMDISK'" get Caption ^| find ":"') DO SET Ramdisk=%%I\Temp
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Edge" /V "UserDataDir"  /T "REG_SZ" /D "%UserProfile%\Documents\EdgeUserData" /F
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Edge" /V "DiskCacheDir" /T "REG_SZ" /D "%Ramdisk%" /F
TIMEOUT /T 5
