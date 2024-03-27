@echo off
:input
echo ====================================================
echo Pleas enter the disk label
echo For example, D or D: or D:\
echo ====================================================
set /p label=^>
set drive=%label:~0,1%:
if not exist "%drive%" cls && goto :input
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
if not exist "%~1" goto :symbomake
rd %1 2>nul && goto :symbomake
xcopy %1 %2 /e /i /h
rd %1 /s /q
:symbomake
mklink /d %1 "%drive%\Home\%~n1"
