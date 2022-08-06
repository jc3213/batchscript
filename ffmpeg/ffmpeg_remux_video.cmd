@ECHO OFF
:Files
IF NOT EXIST "%~1" GOTO :Proc
"%~DP0bin\ffmpeg.exe" -i "%~1" >"%Temp%\ffmpeg_log_%~N1" 2>&1
FOR /F "USEBACKQ SKIP=13 TOKENS=4,5 DELIMS=,: " %%I IN ("%Temp%\ffmpeg_log_%~N1") DO (
	IF "%%I"=="Audio" (
        SET Audio=-i "%~1"
    ) ELSE IF "%%I"=="Video" (
        SET Video=-i "%~1"
        SET Output="%~DP1remuxed_%~N1.mkv"
    )
)
FOR /F "TOKENS=1,* DELIMS= " %%A IN ("%*") DO CALL :Files %%B
:Proc
IF NOT DEFINED Video GOTO :End
"%~DP0bin\ffmpeg.exe" -fflags +genpts %Video% %Audio% -c:v copy -c:a copy %Output%
DEL "%Temp%\ffmpeg_log_*" /F /Q
:End
TIMEOUT -T 5
EXIT
