@echo off
net session >nul 2>&1 && goto :admin
mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c ""%~s0"" %*","%~dp0","runas",1)(window.close)
exit
:admin
echo Hello, world!
pause
