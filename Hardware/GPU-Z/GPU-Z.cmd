@echo off
set app=techpowerup-gpu-z
set exe=GPU-Z.exe
set url=https://www.techpowerup.com/download/%app%/
for /f "tokens=7 delims== " %%i in ('curl "%url%" ^| findstr "name=\"id\""') do (call :download %%i)
:download
for /f %%a in ('wmic logicaldisk where "VolumeName='RAMDISK'" get Caption ^| find ":"') do (set ramdisk=%%a)
if exist "%ramdisk%" (set file=%ramdisk%\%exe%) else (set file=%temp%\%exe%)
curl "%url%" --data-raw "id=%~1&server_id=16" --location --output "%file%"
move /y "%file%" "%~dp0"
timeout /t 5
exit
