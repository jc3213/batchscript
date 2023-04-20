@echo off
if not exist %1 exit
cd /d %1
setlocal enabledelayedexpansion
set /a seek=1
for /f %%a in ('dir /b /a-d') do (call :Menu "%%a")
:Menu
echo ===========================================================
:Option
set filename=%~1
if not defined filename goto :MenuEnd
for /f "tokens=1* delims=-_.() " %%a in ("%filename%") do (call :Text "%%a" "%%b")
:MenuEnd
echo ===========================================================
:Input
set /p index=^> 
echo.
if not defined index goto :Input
echo %index%| findstr /r /c:"^[0-9][0-9]*$" >nul || goto :Input
for /f %%a in ('dir /b /a-d') do (call :Rename "%%a")
timeout /t 5
exit
:Text
echo %~1| findstr /r /c:"^[0-9][0-9]*$" >nul && set better=** || set better=
echo %seek%        ^>^>        %~1  %better%
set /a seek+=1
call :Option %2
:Rename
for /f "tokens=1 delims=-_.() " %%a in (%1) do (call :Filename %1 "%%a")
exit /b
:Filename
set string=#%~2
set length=0
for %%k in (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) do (
    if "!string:~%%k,1!" neq "" (
        set /a length+=%%k
        set string=!string:~%%k!
    )
)
if %length% equ 1 (
    set name=000%~2
) else if %length% equ 2 (
    set name=00%~2
) else if %length% equ 3 (
    set name=0%~2
) else (
    set name=%~2
)
echo %~1        %~2        %name%%~X1
ren %1 %name%%~X1
exit /b
