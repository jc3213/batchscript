@echo off
net session >nul 2>nul && goto :admin
mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c ""%~s0"" %*","","runas",1)(window.close)
exit
:admin
setlocal
for /f %%a in ('wmic logicaldisk where "VolumeName='RAMDISK'" get Caption ^| find ":"') do (set ramdisk=%%a\Temp)
if not exist "%ramdisk%" goto :exit
goto :main
:symbolink
if not exist %1 goto :symbomake
fsutil reparsepoint query %1 | findstr /c:"Symbolic Link" >nul
if not errorlevel 1 goto :symbotrue
xcopy /e /i /h %1 "%ramdisk%"
rd /s /q %1
goto :symbomake
:symbotrue
rd %1
:symbomake
mklink /d %1 "%ramdisk%"
exit /b
:main
taskkill /f /im explorer.exe >nul 2>nul
call :symbolink "%LocalAppData%\Temp"
call :symbolink "%SystemRoot%\Temp"
:exit
endlocal
timeout /t 5
