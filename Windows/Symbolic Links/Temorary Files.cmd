@ECHO OFF
FOR /F %%I in ('wmic logicaldisk where "VolumeName='RAMDISK'" get Caption ^| find ":"') DO SET Ramdisk=%%I\Temp
RD /S /Q "%LocalAppData%\Temp"
RD /S /Q "%SystemRoot%\Temp"
MKLINK /D "%LocalAppData%\Temp" "%Ramdisk%"
MKLINK /D "%SystemRoot%\Temp" "%Ramdisk%"
TIMEOUT /T 5
