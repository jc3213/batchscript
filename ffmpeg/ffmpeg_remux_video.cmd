@echo off
pushd %~dp0bin
for %%a in (%*) do (call :codec %%a)
ffmpeg.exe %file% %map% -c:v copy -c:a copy %output%
:exit
timeout /t 5
exit
:codec
for /f "tokens=3,4 delims= " %%a in ('ffmpeg.exe -i %1 2^>^&1 ^| findstr /i "video audio"') do (call :map "%~1" %%a)
exit /b
:map
echo %1 %2
if "%~2" equ "Video:" goto :video
if "%~2" equ "Audio:" goto :audio
exit /b
:video
set file=-i %1 %file%
set map=-map 0:v %map%
set output="%~dpn1.mkv"
exit /b
:audio
set file=%file% -i %1
set map=%map% -map 1:a
exit /b
