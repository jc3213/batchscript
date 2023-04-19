@echo off
pushd %~dp0bin
set file=%1
if defined file goto :Main
timeout /t 5
exit
:Main
echo =======================================================================
echo Split video by timestamp: 00:12:24
echo Cut video during periods: 00:07:02.33-00:08:04.682
echo File: %1
echo =======================================================================
:Time
set /p clip=^> 
echo.
if not defined clip goto :Time
for /f "tokens=1-2 delims=-" %%a in ('echo %clip%') do (
    set ss=%%a
    set to=%%b
)
if defined to goto :Period
:Stamp
call :Name %ss%
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
:Period
call :Name %ss%
set fn1=%name%
set ts1=%stamp%
call :Name %to%
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
goto :Main
:Name
for /f "tokens=1-3 delims=:" %%a in ('echo %1') do (
    set tf1=%%a
    set tf2=%%b
    set tf3=%%c
)
if not defined tf3 (
    if not defined tf2 (
        set name=00.00.%tf1%
        set stamp=00:00:%tf1%
    ) else (
        set name=00.%tf1%.%tf2%
        set stamp=00:%tf1%:%tf2%
    )
) else (
    set name=%tf1%.%tf2%.%tf3%
    set stamp=%tf1%:%tf2%:%tf3%
)
exit /b
