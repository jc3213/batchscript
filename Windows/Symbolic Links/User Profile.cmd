@echo off
:input
echo ====================================================
echo Please enter the disk label for user profile
echo ====================================================
set /p label=^>
set drive=%label:~0,1%:
if not exist %drive% cls && goto :input
rd /s /q "%UserProfile%\Desktop" 2>nul
rd /s /q "%UserProfile%\Documents" 2>nul
rd /s /q "%UserProfile%\Downloads" 2>nul
rd /s /q "%UserProfile%\Music" 2>nul
rd /s /q "%UserProfile%\Pictures" 2>nul
rd /s /q "%UserProfile%\Saved Games" 2>nul
rd /s /q "%UserProfile%\Videos" 2>nul
md "%drive%\Home\Desktop" 2>nul
md "%drive%\Home\Documents" 2>nul
md "%drive%\Home\Downloads" 2>nul
md "%drive%\Home\Music" 2>nul
md "%drive%\Home\Pictures" 2>nul
md "%drive%\Home\Saved Games" 2>nul
md "%drive%\Home\Videos" 2>nul
mklink /d "%UserProfile%\Desktop" "%drive%\Home\Desktop"
mklink /d "%UserProfile%\Documents" "%drive%\Home\Documents"
mklink /d "%UserProfile%\Downloads" "%drive%\Home\Downloads"
mklink /d "%UserProfile%\Music" "%drive%\Home\Music"
mklink /d "%UserProfile%\Pictures" "%drive%\Home\Pictures"
mklink /d "%UserProfile%\Saved Games" "%drive%\Home\Saved Games"
mklink /d "%UserProfile%\Videos" "%drive%\Home\Videos"
timeout /t 5
