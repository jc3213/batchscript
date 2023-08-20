@echo off
for /f %%a in ('wmic logicaldisk where "VolumeName='RAMDISK'" get Caption ^| find ":"') do (set ramdisk=%%a\Temp)
if not exist "%ramdisk%" goto :return
rd /s /q "%localappdata%\Temp"
rd /s /q "%systemroot%\Temp"
mklink /d "%localappdata%\Temp" "%ramdisk%"
mklink /d "%systemroot%\Temp" "%ramdisk%"
:return
timeout /t 5
