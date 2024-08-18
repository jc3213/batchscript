@echo off
for /f %%a in ('wmic logicaldisk where "VolumeName='RAMDISK'" get Caption ^| find ":"') do (set ramdisk=%%a)
set package=NvidiaProfileInspector.zip
set app=%ramdisk%\Temp\%package%
curl "https://github.com/Orbmu2k/nvidiaProfileInspector/releases/latest/download/%package%" --location --output "%app%"
if %errorlevel% equ 0 goto :extract
:proxy
set /p proxy=Proxy Server: 
for /f "tokens=1 delims=:" %%a in ("%proxy%") do (set test=%%a)
ping %test% >nul 2>nul || goto :proxy
curl "https://github.com/Orbmu2k/nvidiaProfileInspector/releases/latest/download/%package%" --location --output "%app%" --proxy "%proxy%"
:extract
tar -xf "%app%" -C "%~dp0\"
timeout /t 5
