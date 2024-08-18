@echo off
for /f %%a in ('wmic logicaldisk where "VolumeName='RAMDISK'" get Caption ^| find ":"') do (set ramdisk=%%a)
set app=%ramdisk%\NVCleanstall.exe
curl "https://www.techpowerup.com/download/techpowerup-nvcleanstall/" --data-raw "id=2416&server_id=16" --location --output "%app%"
xcopy "%app%" "%~dp0" /y 2>nul
timeout /t 5
