@echo off
:input
echo ====================================================
echo Pleas enter the disk label
echo For example, D or D: or D:\
echo ====================================================
set /p label=^>
set drive=%label:~0,1%:
if not exist %drive% cls && goto :input
call :symbolink "%UserProfile%\Desktop"
call :symbolink "%UserProfile%\Documents"
call :symbolink "%UserProfile%\Downloads"
call :symbolink "%UserProfile%\Music"
call :symbolink "%UserProfile%\Pictures"
call :symbolink "%UserProfile%\Saved Games"
call :symbolink "%UserProfile%\Videos"
timeout /t 5
goto :eof
:symbolink
for /f "tokens=3,4" %%a in ('fsutil reparsepoint query "%1" ^| findstr /c:"Symbolic Link"') do (if "%%a %%b" neq "Symbolic Link" set params=/s /q)
rd %params% %1 2>nul
mklink /d %1 "%drive%\Home\%~n1"
