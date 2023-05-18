@echo off
cd /d %1 || exit
setlocal enabledelayedexpansion
set /a seek=1
for /f "tokens=*" %%a in ('dir /b /a-d') do (call :Menu "%%a")
:Menu
echo %~1
echo ===========================================================
:Option
if %1 equ "" goto :MenuEnd
for /f "tokens=1* delims=-_.() " %%a in (%1) do (call :Text "%%a" "%%b")
:MenuEnd
echo ===========================================================
:Input
set /p index=^> 
echo.
echo %index%| findstr /r "^[1-9][0-9]*$" >nul || goto :Input
for /f "tokens=*" %%a in ('dir /b /a-d') do (call :Rename "%%a")
timeout /t 5
exit
:Text
echo %~1| findstr /r "^[0-9][0-9]*$" >nul && set better=** || set better=
echo %seek%            ^>^>            %~1        %better%
set /a seek+=1
call :Option %2
:Rename
for /f "tokens=%index% delims=-_.() " %%a in (%1) do (call :Filename %1 "%%a")
exit /b
:Filename
set name=0000%~2
set name=%name:~-4%%~x1
echo %~1        %~2        %name%
ren %1 %name%
exit /b
