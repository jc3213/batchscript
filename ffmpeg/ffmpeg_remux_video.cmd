@ECHO OFF
:Files
IF NOT EXIST "%~1" GOTO :Proc
SET Input=-i "%1" %Input%
FOR /F "TOKENS=1,* DELIMS= " %%A IN ("%*") DO CALL :Files %%B
:Proc
IF NOT DEFINED Input GOTO :End
"%~DP0bin\ffmpeg.exe" -fflags +genpts %Input% -c:v copy -c:a copy remuxed_video.mkv
:End
EXIT
