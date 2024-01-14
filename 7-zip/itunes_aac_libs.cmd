@echo off
pushd %~dp0
for /f "tokens=2*" %%a in ('reg query "HKLM\Software\7-Zip" /v "Path"') do (set zip=%%b7z.exe)
if %processor_architecture% equ AMD64 goto :x64
set ver=32
goto :main
:x64
set bit=64
set ver=64
:main
set url=https://www.apple.com/itunes/download/win%ver%
set setup=iTunes%bit%Setup.exe
set itunes=iTunes%bit%.msi
set unpack=%~dp0_iTunes%bit%
set output=%~dp0iTunes%bit%
if exist %setup% goto :unzip
echo Downloading    :  "%url%"
curl %url% --location --output %setup% >nul 2>&1
:unzip
if exist %unpack% goto :copy
md %unpack% %output% 2>nul
echo Extracting     :  "%~dp0%setup%"
"%zip%" e -y %setup% %itunes% >nul 2>&1
echo Uncompressing  :  "%~dp0%itunes%"
msiexec /a %itunes% /qn TARGETDIR="%unpack%" >nul 2>&1
:copy
pushd %unpack%\iTunes
for %%a in (ASL CoreAudioToolbox CoreFoundation libdispatch objc) do (copy /y %%a.dll "%output%" >nul )
copy icudt*.dll "%output%" >nul
copy libicu*.dll "%output%" >nul
pushd %~dp0
del /f /q "%itunes%" "%setup%"
rd /s /q "%unpack%"
echo iTunes Library :  "%output%
start "" "%output%
timeout /t 5
