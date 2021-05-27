@ECHO OFF
:Files
IF NOT EXIST "%1" GOTO :End
%~DP0bin\ffmpeg.exe -i "%1" -strict experimental -c:a aac -b:a 512k %~N1.aac
FOR /F "TOKENS=1,* DELIMS= " %%A IN ("%*") DO CALL :Files %%B
:End
EXIT
