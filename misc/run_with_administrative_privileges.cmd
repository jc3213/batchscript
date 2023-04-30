@echo off
net session >nul 2>&1
if %ErrorLevel% == 0 goto :admin
start "" mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c pushd ""%~dp0"" && ""%~s0","","runas",1)(window.close)
exit
:admin
echo Hello, world!
pause
