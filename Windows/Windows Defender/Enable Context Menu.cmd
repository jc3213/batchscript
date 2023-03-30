@ECHO OFF
REG ADD "HKCR\*\shellex\ContextMenuHandlers\EPP" /VE /T "REG_SZ" /D "{09A47860-11B0-4DA5-AFA5-26D86198A780}" /F
REG ADD "HKCR\Drive\shellex\ContextMenuHandlers\EPP" /VE /T "REG_SZ" /D "{09A47860-11B0-4DA5-AFA5-26D86198A780}" /F
REG ADD "HKCR\Directory\shellex\ContextMenuHandlers\EPP" /VE /T "REG_SZ" /D "{09A47860-11B0-4DA5-AFA5-26D86198A780}" /F
REG ADD "HKCR\CLSID\{09A47860-11B0-4DA5-AFA5-26D86198A780}\InprocServer32" /VE /T "REG_SZ" /D "%ProgramFiles%\Windows Defender\shellext.dll" /F
TIMEOUT /T 5
