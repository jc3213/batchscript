@echo off
net session >nul 2>nul && goto :runasadmin
mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c ""%~s0"" %*","","runas",1)(window.close)
exit
:runasadmin
reg delete "HKCR\*\shell\runas" /f
reg delete "HKCR\Directory\shell\runas" /f
timeout /t 5