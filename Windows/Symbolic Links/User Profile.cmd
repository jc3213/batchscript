@echo off
:input
echo ====================================================
echo Pleas enter the disk label
echo For example, D or D: or D:\
echo ====================================================
set /p label=^>
set drive=%label:~0,1%:
if not exist %drive% cls && goto :input
call :link "%UserProfile%\Desktop"
call :link "%UserProfile%\Documents"
call :link "%UserProfile%\Downloads"
call :link "%UserProfile%\Music"
call :link "%UserProfile%\Pictures"
call :link "%UserProfile%\Saved Games"
call :link "%UserProfile%\Videos"
timeout /t 5
goto :eof
:link
for /f "tokens=3,4" %%a in ('fsutil reparsepoint query "%1" ^| findstr /c:"Symbolic Link"') do (
    if "%%a %%b" neq "Symbolic Link" set params=/s /q
)
rd %params% %1 2>nul
mklink /d %1 "%drive%\Home\%~nx1"
