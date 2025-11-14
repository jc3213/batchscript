@echo off
setlocal
:input
echo ====================================================
echo Pleas enter the disk label
echo For example, D or D: or D:\
echo ====================================================
set /p label=^>
set drive=%label:~0,1%:
if not exist "%drive%" cls && goto :input
taskkill /f /im explorer.exe >nul 2>nul
set UserShell=HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders
reg add "%UserShell%" /v Desktop /t REG_EXPAND_SZ /d "%drive%\Home\Desktop" /f
reg add "%UserShell%" /v Personal /t REG_EXPAND_SZ /d "%drive%\Home\Documents" /f
reg add "%UserShell%" /v Downloads /t REG_EXPAND_SZ /d "%drive%\Home\Downloads" /f
reg add "%UserShell%" /v My Music /t REG_EXPAND_SZ /d "%drive%\Home\Music" /f
reg add "%UserShell%" /v My Pictures /t REG_EXPAND_SZ /d "%drive%\Home\Pictures" /f
reg add "%UserShell%" /v My Video /t REG_EXPAND_SZ /d "%drive%\Home\Videos" /f
start explorer.exe
endlocal
timeout /t 5
