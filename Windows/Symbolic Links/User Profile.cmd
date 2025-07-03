@echo off
net session >nul 2>nul && goto :main
mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c ""%~s0"" %*","%~dp0","runas",1)(window.close)
exit
:main
echo ====================================================
echo Pleas enter the disk label
echo For example, D or D: or D:\
echo ====================================================
set /p label=^> 
set drive=%label:~0,1%:
if not exist "%drive%" cls && goto :main
for %%a in (Desktop Documents Downloads Music Pictures Saved Games Videos) do (call :symbolink %%a)
timeout /t 5
goto :eof
:symbolink
set origin=%userprofile%\%1
set symbol=%drive%\Home\%1
if not exist "%origin%" goto :symbomake
rd "%origin%" 2>nul && goto :symbomake
xcopy "%origin%" "%symbol%" /e /i /h 2>nul
rd "%origin%" /s /q
:symbomake
mklink /d "%origin%" "%symbol%"
