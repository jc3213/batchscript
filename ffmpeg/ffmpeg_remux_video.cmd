@ECHO OFF
:Files
IF NOT EXIST "%~1" (
    GOTO :Proc
)
SET Files=-i "%1" %Files%
FOR /F "tokens=1,* delims= " %%A IN ("%*") DO (
    CALL :Files %%B
)
:Proc
"%~DP0bin\ffmpeg.exe" %Files% -c:v copy -c:a copy remuxed_%~n1.mkv -threads 128
:End
EXIT
