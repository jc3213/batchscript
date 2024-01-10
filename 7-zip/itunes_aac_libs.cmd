@echo off
pushd %~dp0
for /f "tokens=2*" %%a in ('reg query "HKLM\Software\7-Zip" /v "Path"') do (set zip=%%b7z.exe)
if %Processor_Architecture% equ AMD64 goto :x64
set ver=32
goto :main
:x64
set bit=64
set ver=64
:main
set setup=iTunes%bit%Setup.exe
set output=iTunes%bit%
set iTunes=iTunes%bit%.msi
set unpack=%~dp0_iTunes%bit%
if exist %setup% goto :unzip
curl https://www.apple.com/itunes/download/win%ver% --location --output %setup%
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
