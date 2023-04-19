@echo off
reg add "HKCR\*\shellex\ContextMenuHandlers\EPP" /ve /t "REG_SZ" /d "{09A47860-11B0-4DA5-AFA5-26D86198A780}" /f
reg add "HKCR\Drive\shellex\ContextMenuHandlers\EPP" /ve /t "REG_SZ" /d "{09A47860-11B0-4DA5-AFA5-26D86198A780}" /f
reg add "HKCR\Directory\shellex\ContextMenuHandlers\EPP" /ve /t "REG_SZ" /d "{09A47860-11B0-4DA5-AFA5-26D86198A780}" /f
reg add "HKCR\CLSID\{09A47860-11B0-4DA5-AFA5-26D86198A780}\InprocServer32" /ve /t "REG_SZ" /d "%ProgramFiles%\Windows Defender\shellext.dll" /f
tmeout /t 5
