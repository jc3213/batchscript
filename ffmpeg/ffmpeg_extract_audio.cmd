@ECHO OFF
IF NOT EXIST "%~1" EXIT
"%~DP0bin\ffmpeg.exe" -i "%~1" >%Temp%\ffmpeg_log_%~N1.txt 2>&1
FOR /F "USEBACKQ SKIP=13 TOKENS=4,5 DELIMS=,: " %%I IN ("%Temp%\ffmpeg_log_%~N1.txt") DO (
	IF "%%I"=="Audio" SET format=%%J
)
IF "%format%"=="aac" CALL :Extract %1 m4a
IF "%format%"=="opus" CALL :Extract %1 webm
IF "%format%"=="mp3" CALL :Extract %1 mp3
IF "%format%"=="vorbis" CALL :Extract %1 ogg
IF "%format%"=="pcm_s16le" CALL :Extract %1 wav
IF "%format%"=="flac" CALL :Extract %1 flac
IF "%format%"=="alac" CALL :Extract %1 m4a
IF NOT DEFINED ext SET /P ext=Audio Format: 
:Extract
"%~DP0bin\ffmpeg.exe" -i %1 -vn -acodec copy %~n1.%2
DEL /S /Q /F %Temp%\ffmpeg_log_%~N1.txt
EXIT
