@echo off
net session >nul 2>&1 && goto :main
mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c pushd ""%~dp0"" && ""%~s0","","runas",1)(window.close)
exit
:admin
echo Hello, world!
pause
