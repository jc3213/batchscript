@echo off
for /f %%a in ('wmic logicaldisk where "VolumeName='RAMDISK'" get Caption ^| find ":"') do (set ramdisk=%%a\Temp)
if not exist "%ramdisk%" goto :eof
call :link "%localappdata%\Temp"
call :link "%systemroot%\Temp"
timeout /t 5
goto :eof
:link
for /f "tokens=3,4" %%a in ('fsutil reparsepoint query "%1" ^| findstr /c:"Symbolic Link"') do (
    if "%%a %%b" neq "Symbolic Link" set params=/s /q
)
rd %params% %1 2>nul
mklink /d %1 %ramdisk%
