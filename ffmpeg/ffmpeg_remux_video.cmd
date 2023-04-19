@echo off
pushd %~dp0bin
:Files
if not exist "%~1" goto :Remux
ffmpeg.exe -i "%~1" >"%Temp%\ffmpeg_log_%~n1" 2>&1
for /f "usebackq skip=13 tokens=4,5 delims=,: " %%a in ("%Temp%\ffmpeg_log_%~n1") do (
	if "%%a"=="Audio" (
        set Audio=-i "%~1"
    ) else if "%%a"=="Video" (
        set Video=-i "%~1"
        set Output="%~dp1remuxed_%~n1.mkv"
    )
)
for /f "tokens=1,* delims= " %%a in ("%*") do (call :Files %%b)
:Remux
if not defined Video goto :Exit
ffmpeg.exe -fflags +genpts %Video% %Audio% -c:v copy -c:a copy %Output%
del "%Temp%\ffmpeg_log_*" /f /Q
:Exit
timeout /t 5
