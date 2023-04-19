@echo off
for /f %%a in ('wmic logicaldisk where "VolumeName='RAMDISK'" get Caption ^| find ":"') DO SET Ramdisk=%%a\Temp
rd /s /q "%LocalAppData%\Temp"
rd /s /q "%SystemRoot%\Temp"
mklink /d "%LocalAppData%\Temp" "%Ramdisk%"
mklink /d "%SystemRoot%\Temp" "%Ramdisk%"
timeout /t 5
