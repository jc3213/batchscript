@echo off
call :registry "HKCR\*\shell\runas"
call :registry "HKCR\Directory\shell\runas" "/r /d y"
goto :back
:registry
reg add "%~1" /ve /t "REG_SZ" /d "Grant administrator privileges" /f
reg add "%~1" /v "Icon" /t "REG_SZ" /d "C:\Windows\system32\imageres.dll,-78" /f
reg add "%~1" /v "NoWorkingDirectory"  /t "REG_SZ" /d "" /f
reg add "%~1\command" /ve /t "REG_EXPAND_SZ" /d "%%SystemRoot%%\system32\cmd.exe /c takeown /f \"%%1\" %~2 && icacls \"%%1\" /grant Administrators:F" /f
reg add "%~1\command" /v "IsolatedCommand" /t "REG_EXPAND_SZ" /d "%%SystemRoot%%\system32\cmd.exe /c takeown /f \"%%1\" %~2 && icacls \"%%1\" /grant Administrators:F" /f
exit /b
:back
timeout /t 5
