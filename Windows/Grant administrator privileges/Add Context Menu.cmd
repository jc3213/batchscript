@echo off
set File=HKCR\*\shell\runas
set Folder=HKCR\Directory\shell\runas
set Menu=Grant administrator privileges
set Icon=C:\Windows\system32\imageres.dll,-78
set Admin=%%SystemRoot%%\system32\cmd.exe /c takeown /f \"%%1\" ^&^& icacls \"%%1\" /grant Administrators:F
set Admin@=%%SystemRoot%%\system32\cmd.exe /c takeown /f \"%%1\" /R /d Y ^&^& icacls \"%%1\" /grant Administrators:F /t
::File
reg add "%File%" /ve /t "REG_SZ" /d "%Menu%" /f
reg add "%File%" /v "Icon" /t "REG_SZ" /d "%Icon%" /f
reg add "%File%" /v "NoWorkingDirectory"  /t "REG_SZ" /d "" /f
reg add "%File%\command" /ve /t "REG_EXPAND_SZ" /d "%Admin%" /f
reg add "%File%\command" /v "IsolatedCommand" /t "REG_EXPAND_SZ" /d "%Admin%" /f
::Folder
reg add "%Folder%" /ve /t "REG_SZ" /d "%Menu%" /f
reg add "%Folder%" /v "Icon" /t "REG_SZ" /d "%Icon%" /f
reg add "%Folder%" /v "NoWorkingDirectory" /t "REG_SZ" /d "" /f
reg add "%Folder%\command" /ve /t "REG_EXPAND_SZ" /d "%Admin@%" /f
reg add "%Folder%\command" /v "IsolatedCommand" /t "REG_EXPAND_SZ" /d "%Admin@%" /f
::End
timeout /t 5
