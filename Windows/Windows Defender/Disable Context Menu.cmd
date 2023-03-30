@ECHO OFF
REG DELETE "HKCR\*\shellex\ContextMenuHandlers\EPP" /VE /F
REG DELETE "HKCR\Drive\shellex\ContextMenuHandlers\EPP" /VE /F
REG DELETE "HKCR\Directory\shellex\ContextMenuHandlers\EPP" /VE /F
REG DELETE "HKCR\CLSID\{09A47860-11B0-4DA5-AFA5-26D86198A780}\InprocServer32" /VE /F
TIMEOUT /T 5
