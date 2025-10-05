@echo off
net session >nul 2>nul && goto :admin
mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c ""%~s0"" %*","%~dp0","runas",1)(window.close)
exit
:admin
pushd %~dp0
certutil -generateSSTFromWU roots.sst
certutil -addstore Root roots.sst
certutil -setreg chain\ChainCacheResyncFiletime @now
ipconfig /flushdns
taskkill /f /im msedge.exe
pause
