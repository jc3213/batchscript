@echo off
setlocal enabledelayedexpansion
set /p "remove=Remove string: "
cd /d "%~1"
for %%a in (*) do (call :rename "%%~a")
timeout /t 5
exit
:rename
set name=%~n1
set rename=!name:%remove%=!%~x1
echo Rename "%~1" to "%rename%"
ren "%~1" "%rename%"
