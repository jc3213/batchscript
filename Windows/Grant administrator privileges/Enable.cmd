@ECHO OFF
SET File=HKCR\*\shell\runas
SET Folder=HKCR\Directory\shell\runas
SET Menu=Grant administrator privileges
SET Icon=C:\Windows\system32\imageres.dll,-78
SET Admin=%%SystemRoot%%\system32\cmd.exe /C TAKEOWN /F \"%%1\" ^&^& ICACLS \"%%1\" /grant Administrators:F
SET Admin@=%%SystemRoot%%\system32\cmd.exe /C TAKEOWN /F \"%%1\" /R /D Y ^&^& ICACLS \"%%1\" /grant Administrators:F /T
::File
REG ADD "%File%" /VE /T "REG_SZ" /D "%Menu%" /F
REG ADD "%File%" /V "Icon" /T "REG_SZ" /D "%Icon%" /F
REG ADD "%File%" /V "NoWorkingDirectory"  /T "REG_SZ" /D "" /F
REG ADD "%File%\command" /VE /T "REG_EXPAND_SZ" /D "%Admin%" /F
REG ADD "%File%\command" /V "IsolatedCommand" /T "REG_EXPAND_SZ" /D "%Admin%" /F
::Folder
REG ADD "%Folder%" /VE /T "REG_SZ" /D "%Menu%" /F
REG ADD "%Folder%" /V "Icon" /T "REG_SZ" /D "%Icon%" /F
REG ADD "%Folder%" /V "NoWorkingDirectory" /T "REG_SZ" /D "" /F
REG ADD "%Folder%\command" /VE /T "REG_EXPAND_SZ" /D "%Admin@%" /F
REG ADD "%Folder%\command" /V "IsolatedCommand" /T "REG_EXPAND_SZ" /D "%Admin@%" /F
::End
TIMEOUT /T 5
