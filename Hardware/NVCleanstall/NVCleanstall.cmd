@echo off
set app=techpowerup-nvcleanstall
set exe=NVCleanstall.exe
set url=https://www.techpowerup.com/download/%app%/
for /f "tokens=7 delims== " %%i in ('curl "%url%" ^| findstr "name=\"id\""') do ( call :download %%i)
:download
for /f %%a in ('wmic logicaldisk where "VolumeName='RAMDISK'" get Caption ^| find ":"') do (set ramdisk=%%a)
if exist "%ramdisk%" (set exe=%ramdisk%\%exe%) else (set exe=%temp%\%exe%)
curl "%url%" --data-raw "id=%~1&server_id=16" --location --output "%ramdisk%\%exe%"
xcopy "%exe%" "%~dp0" /y 2>nul
timeout /t 5
exit
