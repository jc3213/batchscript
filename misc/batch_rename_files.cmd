@echo off
if not exist %1 exit
cd /d %1
set /a seek=1
for /f %%a in ('dir /b /a-d') do (call :main "%%a")
:main
echo ===========================================================
:menst
set filename=%~1
if not defined filename goto :mened
for /f "tokens=1* delims=-_.() " %%a in ("%filename%") do (call :menu "%%a" "%%b")
:mened
echo ===========================================================
:input
set /p index=^> 
echo.
echo %index%| findstr /r "^[1-9][0-9]*$" >nul || goto :input
for /f %%a in ('dir /b /a-d') do (call :rename "%%a")
timeout /t 5
exit
:menu
echo %~1| findstr /r "^[0-9][0-9]*$" >nul && set better=** || set better=
echo %seek%            ^>^>            %~1        %better%
set /a seek+=1
call :menst %2
:rename
for /f "tokens=%index% delims=-_.() " %%a in (%1) do (call :exec %1 "%%a")
exit /b
:exec
set input=%~2
set name=000%input%
set name=%name:~-4%
echo %~1        %~2        %name%%~X1
ren %1 %name%%~X1
exit /b
