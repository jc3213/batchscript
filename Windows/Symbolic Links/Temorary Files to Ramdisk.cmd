@echo off
for /f %%a in ('wmic logicaldisk where "VolumeName='RAMDISK'" get Caption ^| find ":"') do (set ramdisk=%%a\Temp)
if not exist "%ramdisk%" goto :eof
call :symbolink "%localappdata%\Temp"
call :symbolink "%systemroot%\Temp"
timeout /t 5
goto :eof
:symbolink
if not exist "%~1" goto :symbomake
for /f "tokens=3,4" %%a in ('fsutil reparsepoint query "%~1" ^| findstr /c:"Symbolic Link"') do (call :symbotest %1 %2 "%%a %%b")
:symbotest
if "%~3" equ "Symbolic Link" goto :symbotrue
rd /s /q %1
goto :symbomake
:symbotrue
rd %1
:symbomake
mklink /d %1 "%ramdisk%"
