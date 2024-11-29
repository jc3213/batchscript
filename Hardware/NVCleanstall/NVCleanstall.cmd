@echo off
set url=https://www.techpowerup.com/download/techpowerup-nvcleanstall/
set app=NVCleanstall.exe
for /f "tokens=7 delims== " %%i in ('curl "%url%" ^| findstr "name=\"id\""') do ( call :app %%i)
:app
for /f %%a in ('wmic logicaldisk where "VolumeName='RAMDISK'" get Caption ^| find ":"') do (set ramdisk=%%a)
curl "%url%" --data-raw "id=%~1&server_id=16" --location --output "%ramdisk%\%app%"
xcopy "%app%" "%~dp0" /y 2>nul
timeout /t 5
exit
