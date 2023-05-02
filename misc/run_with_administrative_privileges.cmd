@echo off
net session >nul 2>&1
if %ErrorLevel% equ 0 goto :admin
mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c pushd ""%~dp0"" && ""%~s0","","runas",1)(window.close)
exit
:admin
echo Hello, world!
pause
