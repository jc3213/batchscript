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
md "%Drive%:\Home\Desktop" 2>nul
md "%Drive%:\Home\Documents" 2>nul
md "%Drive%:\Home\Downloads" 2>nul
md "%Drive%:\Home\Music" 2>nul
md "%Drive%:\Home\Pictures" 2>nul
md "%Drive%:\Home\Saved Games" 2>nul
md "%Drive%:\Home\Videos" 2>nul
mklink /d "%UserProfile%\Desktop" "%Drive%:\Home\Desktop"
mklink /d "%UserProfile%\Documents" "%Drive%:\Home\Documents"
mklink /d "%UserProfile%\Downloads" "%Drive%:\Home\Downloads"
mklink /d "%UserProfile%\Music" "%Drive%:\Home\Music"
mklink /d "%UserProfile%\Pictures" "%Drive%:\Home\Pictures"
mklink /d "%UserProfile%\Saved Games" "%Drive%:\Home\Saved Games"
mklink /d "%UserProfile%\Videos" "%Drive%:\Home\Videos"
timeout /t 5
