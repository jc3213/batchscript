@ECHO OFF
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Edge" /V "UserDataDir"  /T "REG_SZ" /D "%UserProfile%\Documents\EdgeUserData" /F
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Edge" /V "DiskCacheDir" /T "REG_SZ" /D "%Temp%" /F
TIMEOUT /T 5
