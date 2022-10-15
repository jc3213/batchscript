@ECHO OFF
PUSHD %~DP0bin
SET file=%1
CALL :Separator
ECHO File path sample: C:\Program Files\ffmpeg\my video.mp4
ECHO Split after specific timestamp: 00:01:02.345
ECHO Split by parts based on timestamp: 00:01:02.123-00:03:04.345
ECHO Short timestamp format 01:23.456 and 12.345 are also available
CALL :Separator
ECHO.
:Main
CALL :File
CALL :Time
IF NOT DEFINED to (
    CALL :Stamp %file%
) ELSE (
    CALL :Period %file%
)
CALL :Clear
GOTO :Main
:File
IF NOT DEFINED file (
    SET /P file=Select File: 
) ELSE (
    ECHO Current file: %file%
)
IF NOT DEFINED file GOTO :File
EXIT /B
:Time
SET /P clip=Timestamp: 
IF NOT DEFINED clip GOTO :Time
FOR /F "tokens=1-2 delims=-" %%I IN ('ECHO %clip%') DO (
    SET ss=%%I
	SET to=%%J
)
EXIT /B
:Name
FOR /F "tokens=1-3 delims=:" %%I IN ('ECHO %1') DO (
    SET tf1=%%I
	SET tf2=%%J
	SET tf3=%%K
)
IF NOT DEFINED tf3 (
    IF NOT DEFINED tf2 (
        SET name=00.00.%tf1%
        SET stamp=00:00:%tf1%
    ) ELSE (
        SET name=00.%tf1%.%tf2%
        SET stamp=00:%tf1%:%tf2%
    )
) ELSE (
    SET name=%tf1%.%tf2%.%tf3%
    SET stamp=%tf1%:%tf2%:%tf3%
)
EXIT /B
:Stamp
CALL :Name %ss%
SET fn0=%name%
SET ts0=%stamp%
SET out1=%~DP1%~N1_%fn0%_1%~X1
SET out2=%~DP1%~N1_%fn0%_2%~X1
ffmpeg.exe -i "%1" -to %ss% -c copy %out1%
ffmpeg.exe -i "%1" -ss %ss% -c copy %out2%
CALL :Warning WarnStamp
EXIT /B
:WarnStamp
ECHO [Mode]        Split after specific timestamp
ECHO [Timestamp]   %ts0%
ECHO [Output]      %out1%, %out2%
EXIT /B
:Period
CALL :NAME %ss%
SET fn1=%name%
SET ts1=%stamp%
CALL :NAME %to%
SET fn2=%name%
SET ts2=%stamp%
SET out0=%~DP1%~N1_%fn1%-%fn2%%~X1
ffmpeg.exe -i "%1" -ss %ss% -to %to% -c copy %out0%
CALL :Warning WarnPeriod
EXIT /B
:WarnPeriod
ECHO [Mode]        Split by parts based on timestamp
ECHO [Timestamp]   %ts1%-%ts2%
ECHO [Output]      %out0%
EXIT /B
:Warning
ECHO.
CALL :Separator
ECHO [Input]       %file%
CALL :%1
CALL :Separator
ECHO.
EXIT /B
:Separator
ECHO =======================================================================
EXIT /B
:Clear
SET clip=
SET name=
SET stamp=
SET ss=
SET to=
EXIT /B
