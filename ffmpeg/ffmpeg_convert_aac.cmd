@echo off
pushd %~dp0bin
for %%a in (%*) do (call :aac)
timeout /t 5
exit
:aac
ffmpeg.exe -i "%1" -strict experimental -c:a aac -b:a 512k %~n1.aac
