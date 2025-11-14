@echo off
net session >nul 2>nul && goto :admin
mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c ""%~s0"" %*","","runas",1)(window.close)
exit
:admin
setlocal
for /f %%a in ('wmic logicaldisk where "VolumeName='RAMDISK'" get Caption ^| find ":"') do (set ramdisk=%%a\Temp)
if not exist "%ramdisk%" goto :exit
taskkill /f /im explorer.exe >nul 2>nul
set "UserEnv=HKCU\Environment"
reg add "%UserEnv%" /v TEMP /t REG_EXPAND_SZ /d "%ramdisk%" /f
reg add "%UserEnv%" /v TMP  /t REG_EXPAND_SZ /d "%ramdisk%" /f
set "SysEnv=HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment"
reg add "%SysEnv%" /v TEMP /t REG_EXPAND_SZ /d "%ramdisk%" /f
reg add "%SysEnv%" /v TMP  /t REG_EXPAND_SZ /d "%ramdisk%" /f
start explorer.exe
:exit
endlocal
timeout /t 5
