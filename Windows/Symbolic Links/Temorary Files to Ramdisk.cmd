@echo off
for /f %%a in ('wmic logicaldisk where "VolumeName='RAMDISK'" get Caption ^| find ":"') do (set ramdisk=%%a\Temp)
if not exist "%ramdisk%" goto :eof
call :symbolink "%localappdata%\Temp"
call :symbolink "%systemroot%\Temp"
timeout /t 5
goto :eof
:symbolink
rd %1 2>nul
mklink /d %1 %ramdisk%
