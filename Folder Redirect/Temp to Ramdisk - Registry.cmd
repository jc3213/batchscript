@echo off
net session >nul 2>nul && goto :admin
mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c ""%~s0"" %*","","runas",1)(window.close)
exit
:registry
reg add "%~1" /v "TEMP" /t "REG_EXPAND_SZ" /d "%ramdisk%" /f
reg add "%~1" /v "TMP" /t "REG_EXPAND_SZ" /d "%ramdisk%" /f
exit /b
:admin
setlocal
for /f %%a in ('wmic logicaldisk where "VolumeName='RAMDISK'" get Caption ^| find ":"') do (set ramdisk=%%a\Temp)
if not exist "%ramdisk%" goto :exit
call :registry "HKCU\Environment"
call :registry "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment"
taskkill /f /im explorer.exe >nul 2>nul && start explorer.exe
:exit
endlocal
timeout /t 5
