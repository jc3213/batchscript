@echo off
pushd %~dp0bin
set file=%1
call :Separator
echo File path sample: C:\Program Files\ffmpeg\my video.mp4
echo Split after specific timestamp: 00:01:02.345
echo Split by parts based on timestamp: 00:01:02.123-00:03:04.345
echo Short timestamp format 01:23.456 and 12.345 are also available
call :Separator
echo.
:Main
call :File
call :Time
if not defined to (
    call :Stamp %file%
) else (
    call :Period %file%
)
call :Clear
goto :Main
:File
if not defined file (
    set /p file=Select File: 
) else (
    echo Current file: %file%
)
if not defined file goto :File
exit /b
:Time
set /p clip=Timestamp: 
if not defined clip goto :Time
for /f "tokens=1-2 delims=-" %%a in ('echo %clip%') do (
    set ss=%%a
	set to=%%b
)
exit /b
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
:Stamp
call :Name %ss%
set fn0=%name%
set ts0=%stamp%
set out1=%~dp1%~n1_%fn0%_1%~x1
set out2=%~dp1%~n1_%fn0%_2%~x1
ffmpeg.exe -i "%1" -to %ss% -c copy %out1%
ffmpeg.exe -i "%1" -ss %ss% -c copy %out2%
call :Warning WarnStamp
exit /b
:WarnStamp
echo [Mode]        Split after specific timestamp
echo [Timestamp]   %ts0%
echo [Output]      %out1%, %out2%
exit /b
:Period
call :Name %ss%
set fn1=%name%
set ts1=%stamp%
call :Name %to%
set fn2=%name%
set ts2=%stamp%
set out0=%~dp1%~n1_%fn1%-%fn2%%~x1
ffmpeg.exe -i "%1" -ss %ss% -to %to% -c copy %out0%
call :Warning WarnPeriod
exit /b
:WarnPeriod
echo [Mode]        Split by parts based on timestamp
echo [Timestamp]   %ts1%-%ts2%
echo [Output]      %out0%
exit /b
:Warning
echo.
call :Separator
echo [input]       %file%
call :%1
call :Separator
echo.
exit /b
:Separator
echo =======================================================================
exit /b
:Clear
set clip=
set name=
set stamp=
set ss=
set to=
exit /b
