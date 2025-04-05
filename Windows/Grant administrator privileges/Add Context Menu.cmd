@echo off
net session >nul 2>nul && goto :runasadmin
mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c ""%~s0"" %*","","runas",1)(window.close)
exit
:runasadmin
setlocal
for /f "tokens=2 delims==" %%a in ('wmic os get Locale /value') do (set locale=%%a)
if "%locale%" equ "0804" call :main "授予管理员权限"
if "%locale%" equ "0404" call :main "授予管理員權限"
if "%locale%" equ "0411" call :main "管理者権限を付与します"
call :main "Grant administrator privileges"
:main
set icon=C:\Windows\system32\imageres.dll,-78
set admin=%%SystemRoot%%\system32\cmd.exe /c takeown /f \"%%1\" ^&^& icacls \"%%1\" /grant Administrators:F
set admin@=%%SystemRoot%%\system32\cmd.exe /c takeown /f \"%%1\" /r /d y ^&^& icacls \"%%1\" /grant Administrators:F /t
:file
reg add "HKCR\*\shell\runas" /ve /t "REG_SZ" /d %1 /f
reg add "HKCR\*\shell\runas" /v "Icon" /t "REG_SZ" /d "%icon%" /f
reg add "HKCR\*\shell\runas" /v "NoWorkingDirectory"  /t "REG_SZ" /d "" /f
reg add "HKCR\*\shell\runas\command" /ve /t "REG_EXPAND_SZ" /d "%admin%" /f
reg add "HKCR\*\shell\runas\command" /v "IsolatedCommand" /t "REG_EXPAND_SZ" /d "%admin%" /f
:folder
reg add "HKCR\Directory\shell\runas" /ve /t "REG_SZ" /d %1 /f
reg add "HKCR\Directory\shell\runas" /v "Icon" /t "REG_SZ" /d "%icon%" /f
reg add "HKCR\Directory\shell\runas" /v "NoWorkingDirectory" /t "REG_SZ" /d "" /f
reg add "HKCR\Directory\shell\runas\command" /ve /t "REG_EXPAND_SZ" /d "%admin@%" /f
reg add "HKCR\Directory\shell\runas\command" /v "IsolatedCommand" /t "REG_EXPAND_SZ" /d "%admin@%" /f
timeout /t 5
exit
