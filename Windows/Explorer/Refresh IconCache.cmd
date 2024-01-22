@echo off
net session >nul 2>nul && goto :admin
mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c ""%~s0"" %*","%~dp0","runas",1)(window.close)
exit
:admin
taskkill /f /im "explorer.exe"
cd /d %localappdata%\Microsoft\Windows\Explorer
for %%a in (*.*) do (call :refresh "%%~a")
start "" "explorer.exe"
timeout /t 5
exit
:refresh
takeown /f %1
icacls %1 /grant Administrators:F
attrib -h -s -r %1
del /f /q /a %1
