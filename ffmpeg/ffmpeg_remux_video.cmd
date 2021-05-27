@ECHO OFF
:Files
IF NOT EXIST "%~1" GOTO :Proc
"%~DP0bin\ffmpeg.exe" -i "%~1" >%Temp%\ffmpeg_log_%~N1.txt 2>&1
FOR /F "USEBACKQ SKIP=13 TOKENS=4,5 DELIMS=,: " %%I IN ("%Temp%\ffmpeg_log_%~N1.txt") DO (
	IF "%%I"=="Audio" (
        SET Audio=-i "%~1"
    ) ELSE IF "%%I"=="Video" (
        SET Video=-i "%~1"
    )
)
SET Input=%Video% %Audio%
FOR /F "TOKENS=1,* DELIMS= " %%A IN ("%*") DO CALL :Files %%B
:Proc
IF NOT DEFINED Input GOTO :End
"%~DP0bin\ffmpeg.exe" -fflags +genpts %Input% -c:v copy -c:a copy remuxed_video.mkv
:End
EXIT
