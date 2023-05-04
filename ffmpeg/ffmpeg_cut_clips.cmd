@echo off
pushd %~dp0bin
set file=%1
if defined file goto :main
timeout /t 5
exit
:main
echo =======================================================================
echo Split video by timestamp: 00:12:24
echo Cut video during periods: 00:07:02.33-00:08:04.682
echo File: %1
echo =======================================================================
:input
set /p clip=^> 
echo.
if not defined clip goto :input
for /f "tokens=1,2 delims=-" %%a in ('echo %clip%') do (
    set ss=%%a
    set to=%%b
)
if defined to goto :period
:stamp
call :name %ss%
set fn0=%name%
set ts0=%stamp%
set out1=%~dp1%~n1_%fn0%_1%~x1
set out2=%~dp1%~n1_%fn0%_2%~x1
ffmpeg.exe -i "%1" -to %ss% -c copy %out1%
ffmpeg.exe -i "%1" -ss %ss% -c copy %out2%
echo.
echo.
echo =======================================================================
echo [Mode]        Split video by timestamp
echo [Timestamp]   %ts0%
echo [Output]      %out1%
echo [Output]      %out2%
echo =======================================================================
goto :Clear
:period
call :name %ss%
set fn1=%name%
set ts1=%stamp%
call :name %to%
set fn2=%name%
set ts2=%stamp%
set out0=%~dp1%~n1_%fn1%-%fn2%%~x1
ffmpeg.exe -i "%1" -ss %ss% -to %to% -c copy %out0%
echo.
echo.
echo =======================================================================
echo [Mode]        Cut video during periods
echo [Period]      %ts1%-%ts2%
echo [Output]      %out0%
echo =======================================================================
echo.
:Clear
set clip=
set name=
set stamp=
set ss=
set to=
echo.
echo.
echo.
echo.
goto :main
:name
for /f "tokens=1-3 delims=:" %%a in ('echo %1') do (
    set hh=00%%a
    set mm=00%%b
    set ss=00%%c
)
set hh=%hh:~-2%
set mm=%hh:~-2%
set ss=%ss:~-2%
set name=%hh%.%mm%.%ss%
set stamp=%hh%:%mm%:%ss%
exit /b
