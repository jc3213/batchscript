@echo off
net session >nul 2>nul && goto :admin
mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c ""%~s0"" %*","","runas",1)(window.close)
exit
:admin
setlocal
:input
echo ====================================================
echo Pleas enter the disk label
echo For example, D or D: or D:\
echo ====================================================
set /p label=^>
set drive=%label:~0,1%:
if not exist "%drive%" cls && goto :input
goto :main
:symbolink
set source=%UserProfile%\%~1
set target=%drive%\Home\%~1
if not exist "%source%" goto :symbomake
fsutil reparsepoint query "%source%" | findstr /c:"Symbolic Link" >nul
if not errorlevel 1 goto :symbotrue
xcopy /e /i /h "%source%" "%target%" >nul
rd /s /q "%source%"
goto :symbomake
:symbotrue
rd "%source%"
:symbomake
mklink /d "%source%" "%target%"
exit /b
:main
taskkill /f /im explorer.exe >nul 2>nul
call :symbolink "Desktop"
call :symbolink "Documents"
call :symbolink "Downloads"
call :symbolink "Music"
call :symbolink "Pictures"
call :symbolink "Saved Games"
call :symbolink "Videos"
start explorer.exe
endlocal
timeout /t 5
