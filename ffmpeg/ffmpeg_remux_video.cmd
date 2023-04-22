@echo off
pushd %~dp0bin
for %%a in (%*) do (call :codec %%a)
if not defined video goto :exit
if not defined audio goto :exit
ffmpeg.exe -fflags +genpts %video% %audio% %image% -c:v copy -c:a copy %thumb% %output%
:exit
timeout /t 5
exit
:codec
if %~x1 equ .jpg call :thumb %1 mjpg
if %~x1 equ .png call :thumb %1 png
for /f "tokens=3,4 delims= " %%a in ('ffmpeg.exe -i %1 2^>^&1 ^| findstr /i "video audio"') do (
    if "%%a" equ "Audio:" (
        set audio=-i %1
    ) else if "%%a" equ "Video:" (
        set video=-i %1
        set output="%~dp1remuxed_%~n1.mkv"
    )
)
exit /b
:thumb
set image=-i %1 -map 0 -map 1 -map 2
set thumb=-c:v:2 %2 -disposition:2 attached_pic
exit /b
