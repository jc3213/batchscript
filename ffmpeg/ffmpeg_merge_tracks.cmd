@echo off
pushd %~dp0bin
for %%a in (%*) do (call :merge %%a)
if %index% lss 2 goto :exit
ffmpeg.exe %input% -filter_complex "amerge=inputs=%index%" %~dp1merged_audio_track%~x1
:exit
timeout /t 5
exit
:merge
set /a index+=1
set input=-i "%1" %input%
