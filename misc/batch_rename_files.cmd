@echo off
setlocal enabledelayedexpansion
cd /d %1 || exit
set length=0
for /f "usebackq delims=" %%a in (`dir /b /a-d ^| find /v /c "::"`) do (set count=%%a)
call :length
for /f "tokens=*" %%a in ('dir /b /a-d') do (call :main "%%a")
:main
echo ============================================================
echo @                          %~1
echo ============================================================
:menu
for /f "tokens=1* delims=-_.() " %%a in (%1) do (call :item "%%~a" "%%~b")
:item
set /a index+=1
echo %~1| findstr /r "^[0-9][0-9]*$" >nul && set better=** || set better=
echo %index%            ^>^>            %~1        %better%
if "%~2" equ "" goto :mend
call :menu %2
:mend
echo ============================================================
:input
set /p act=^> 
echo.
if %act% gtr %index% goto :input
for /f "tokens=*" %%a in ('dir /b /a-d') do (call :rename "%%~a")
timeout /t 5
exit
:length
set count=!count:~1!
set /a length+=1
if not defined count exit /b
goto :length
:rename
for /f "tokens=%act% delims=-_.() " %%a in ("%~1") do (call :exec "%~1" "%%a")
exit /b
:exec
set name=00000%~2
set name=!name:~-%length%!%~x1
echo %~1        %~2        %name%
ren %1 %name%
exit /b
