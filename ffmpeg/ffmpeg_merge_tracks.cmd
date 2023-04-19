@echo off
pushd %~dp0bin
set /a index=0
for %%a in (%*) do (call :Merge %%a)
if %index% lss 2 goto :Exit
ffmpeg.exe %input% -filter_complex "amerge=inputs=%index%" %~dp1merged_audio_track%~x1
:Exit
timeout /t 5
exit
:Merge
set /a index+=1
set input=-i "%1" %input%
