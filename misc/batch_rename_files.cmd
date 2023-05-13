@echo off
if not exist %1 exit
cd /d %1
for /f %%a in ('dir /b /a-d') do (call :main "%%a")
:main
echo ============================================================
:menu
for /f "tokens=1* delims=-_.() " %%a in (%1) do (call :item "%%a" "%%b")
:item
set /a index+=1
echo %~1| findstr /r "^[0-9][0-9]*$" >nul && set better=** || set better=
echo %index%            ^>^>            %~1        %better%
if %2 equ "" goto :mend
call :menu %2
:mend
echo ============================================================
:input
set /p act=^> 
echo.
if %act% gtr %index% goto :input
for /f %%a in ('dir /b /a-d') do (call :rename "%%a")
timeout /t 5
exit
:rename
for /f "tokens=%act% delims=-_.() " %%a in (%1) do (call :exec %1 "%%a")
exit /b
:exec
set input=%~2
set name=000%input%
set name=%name:~-4%
echo %~1        %~2        %name%%~x1
ren %1 %name%%~x1
exit /b
