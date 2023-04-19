@echo off
pushd %~dp0
for /f "tokens=1,2*" %%a in ('reg query HKLM\Software\7-Zip /V Path') do (if "%%a"=="Path" set Zip=%%c7z.exe)
if %PROCESSOR_ARCHITECTURE% equ AMD64 (call :X64) else (call :X86)
set Installer=iTunes%Arch%Setup.exe
if exist %Installer% goto :Extractor
curl https://www.apple.com/itunes/download/win%Arch% --location --output %Installer%
:Extractor
md %Unpack% 2>nul
md %Output% 2>nul
"%Zip%" e -y %Installer% %iTunes%
msiexec /a %iTunes% /qn TARGETDIR="%Unpack%"
copy %Unpack%\iTunes\ASL.dll %Output%
copy %Unpack%\iTunes\CoreAudioToolbox.dll %Output%
copy %Unpack%\iTunes\CoreFoundation.dll %Output%
copy %Unpack%\iTunes\icudt*.dll %Output%
copy %Unpack%\iTunes\libdispatch.dll %Output%
copy %Unpack%\iTunes\libicuin.dll %Output%
copy %Unpack%\iTunes\libicuuc.dll %Output%
copy %Unpack%\iTunes\objc.dll %Output%
del %iTunes% 2>nul
del %Installer% 2>nul
rd %Unpack% /s /q 2>nul
:Exit
timeout /t 5
exit
:X64
set Arch=64
set Output=iTunes64
set iTunes=iTunes64.msi
set Unpack=%CD%\.iTunes64
exit /b
:X86
set Arch=32
set Output=iTunes
set iTunes=iTunes.msi
set Unpack=%CD%\.iTunes
exit /b
