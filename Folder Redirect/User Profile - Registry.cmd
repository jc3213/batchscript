@echo off
net session >nul 2>nul && goto :admin
mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c ""%~s0"" %*","","runas",1)(window.close)
exit
:registry
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v "%~1" /t REG_EXPAND_SZ /d "%drive%\Home\%~2" /f
exit /b
:admin
echo ====================================================
echo Pleas enter the disk label
echo For example, D or D: or D:\
echo ====================================================
set /p label=^>
set drive=%label:~0,1%:
if not exist "%drive%" cls && goto :admin
call :registry "Desktop" "Desktop"
call :registry "Personal" "Documents"
call :registry "Downloads" "Downloads"
call :registry "My Music" "Music"
call :registry "My Pictures" "Pictures"
call :registry "My Video" "Videos"
taskkill /f /im explorer.exe >nul 2>nul
start explorer.exe
endlocal
timeout /t 5
