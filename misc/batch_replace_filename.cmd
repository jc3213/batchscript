@echo off
setlocal enabledelayedexpansion
cd /d "%~1" || exit
set /p rem=Remove string: 
for %%a in (*) do (call :rename "%%~a")
timeout /t 5
exit
:rename
set name=%~n1
set name=!name:%rem%=!
ren %1 %name%%~x1
echo Removed "%rem%" from "%~1"
