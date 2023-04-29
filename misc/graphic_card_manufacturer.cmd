@echo off
for /f "tokens=2 delims==" %%a in ('wmic path win32_videocontroller get name /value ^| findstr /i "name"') do (set graphic=%%a)
for /f "tokens=1 delims= " %%b in ("%graphic%") do (set manufacturer=%%b)
echo Graphic Card: %graphic%
echo Manufacturer: %manufacturer%
timeout /t 5
