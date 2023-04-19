@echo off
pushd %~dp0bin
for %%a in (%*) do (call :Check %%a)
echo %video% %audio%
pause
if not defined video goto :Exit
if not defined audio goto :Exit
ffmpeg.exe -fflags +genpts %Video% %Audio% -c:v copy -c:a copy %Output%
:Exit
timeout /t 5
exit
:Check
for /f "tokens=3,4 delims= " %%a in ('ffmpeg.exe -i %1 2^>^&1 ^| findstr /i "video audio"') do (
	if "%%a"=="Audio:" (
        set Audio=-i %1
    ) else if "%%a"=="Video:" (
        set Video=-i %1
        set Output="%~dp1remuxed_%~n1.mkv"
    )
)
