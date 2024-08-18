@echo off
for /f %%a in ('wmic logicaldisk where "VolumeName='RAMDISK'" get Caption ^| find ":"') do (set ramdisk=%%a)
set package=NvidiaProfileInspector.zip
set app=%ramdisk%\%package%
set folder=%app:~0,-4%
curl "https://github.com/Orbmu2k/nvidiaProfileInspector/releases/latest/download/%package%" --location --output "%app%"
if %errorlevel% equ 0 goto :extract
curl "https://github.com/Orbmu2k/nvidiaProfileInspector/releases/latest/download/%package%" --location --output "%app%" --proxy "127.0.0.1:7890"
:extract
md "%folder%" >nul 2>nul
tar -xf %package% -C "%folder%"
timeout /t 5
