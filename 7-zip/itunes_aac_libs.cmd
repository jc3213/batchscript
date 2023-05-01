@echo off
pushd %~dp0
for /f "tokens=2*" %%a in ('reg query "HKLM\Software\7-Zip" /v "Path"') do (set zip=%%b7z.exe)
if %Processor_architecture% equ AMD64 (call :x64) else (call :x86)
set setup=iTunes%arch%Setup.exe
if exist %setup% goto :unzip
curl https://www.apple.com/itunes/download/win%arch% --location --output %setup%
:unzip
"%zip%" e -y %setup% %iTunes%
md %unpack% 2>nul
md %output% 2>nul
msiexec /a %iTunes% /qn TARGETDIR="%unpack%"
copy %unpack%\iTunes\ASL.dll %output%
copy %unpack%\iTunes\CoreAudioToolbox.dll %output%
copy %unpack%\iTunes\CoreFoundation.dll %output%
copy %unpack%\iTunes\icudt*.dll %output%
copy %unpack%\iTunes\libdispatch.dll %output%
copy %unpack%\iTunes\libicuin.dll %output%
copy %unpack%\iTunes\libicuuc.dll %output%
copy %unpack%\iTunes\objc.dll %output%
del %iTunes% 2>nul
del %setup% 2>nul
rd %unpack% /s /q 2>nul
timeout /t 5
exit
:x64
set arch=64
set output=iTunes64
set iTunes=iTunes64.msi
set unpack=%CD%\_iTunes64
exit /b
:x86
set arch=32
set output=iTunes
set iTunes=iTunes.msi
set unpack=%CD%\_iTunes
exit /b
