@ECHO OFF
SET Index=0
:Files
IF NOT EXIST "%~1" (
    GOTO :Proc
)
SET Files=-i "%1" %Files%
SET /A Index=%Index%+1
FOR /F "tokens=1,* delims= " %%A IN ("%*") DO (
    CALL :Files %%B
)
:Proc
IF NOT DEFINED Files GOTO :End
"%~DP0bin\ffmpeg.exe" %Files% -filter_complex "amerge=inputs=%Index%" merged_audio_track%~x1
:End
EXIT
