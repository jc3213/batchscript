@echo off
for %%a in (%*) do (call :frame "%%~fa")
timeout /t 30
exit
:frame
set output=%~dp1%~n1_frame
md %output% >nul 2>nul
"%~dp0bin\ffmpeg.exe" -i "%~1" "%output%\%%05d.png"
