@echo off
pushd %~dp0bin
for %%a in (%*) do (call :Check %%a)
if not defined video goto :Exit
if not defined audio goto :Exit
ffmpeg.exe -fflags +genpts %video% %audio% -c:v copy -c:a copy %output%
:Exit
timeout /t 5
exit
:Check
for /f "tokens=3,4 delims= " %%a in ('ffmpeg.exe -i %1 2^>^&1 ^| findstr /i "video audio"') do (
	if "%%a"=="Audio:" (
        set audio=-i %1
    ) else if "%%a"=="Video:" (
        set video=-i %1
        set output="%~dp1remuxed_%~n1.mkv"
    )
)
