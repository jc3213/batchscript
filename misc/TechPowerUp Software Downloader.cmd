@echo off
:software
cls
echo ------------------------------------------------------
echo                  Select Software
echo ------------------------------------------------------
echo 1. GPU-Z
echo 2. NVCleanstall
echo ------------------------------------------------------
set /p soft=^? 
if [%soft%] equ [1] goto :gpuz
if [%soft%] equ [2] goto :nvcleanstall
goto :software
:gpuz
set app=techpowerup-gpu-z
set exe=GPU-Z.exe
goto :server
:nvcleanstall
set app=techpowerup-nvcleanstall
set exe=NVCleanstall.exe
goto :server
:server
cls
echo ------------------------------------------------------
echo                  Select Server
echo ------------------------------------------------------
echo 1. TechPowerUp US-3 [Default]
echo 2. TechPowerUp SG
echo 3. TechPowerUp NL
echo 4. TechPowerUp DE
echo 5. TechPowerUp UK-1
echo ------------------------------------------------------
set /p svr=^? 
if [%svr%] equ [2] set server=15
if [%svr%] equ [3] set server=14
if [%svr%] equ [4] set server=8
if [%svr%] equ [5] set server=5
if not defined server set server=16
:softid
cls
set url=https://www.techpowerup.com/download/%app%/
for /f "tokens=7 delims== " %%i in ('curl "%url%" ^| findstr "name=\"id\""') do (call :download %%i)
:download
for /f %%a in ('wmic logicaldisk where "VolumeName='RAMDISK'" get Caption ^| find ":"') do (set ramdisk=%%a)
if exist "%ramdisk%" (set file=%ramdisk%\%exe%) else (set file=%temp%\%exe%)
curl "%url%" --data-raw "id=%~1&server_id=%server%" --location --output "%file%"
move /y "%file%" "%~dp0"
timeout /t 5
exit
