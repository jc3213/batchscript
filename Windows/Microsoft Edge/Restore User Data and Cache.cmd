@ECHO OFF
REG DELETE "HKLM\SOFTWARE\Policies\Microsoft\Edge" /V "UserDataDir" /F
REG DELETE "HKLM\SOFTWARE\Policies\Microsoft\Edge" /V "DiskCacheDir" /F
TIMEOUT /T 5