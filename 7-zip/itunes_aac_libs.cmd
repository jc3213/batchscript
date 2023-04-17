@ECHO OFF
PUSHD %~DP0
FOR /F "tokens=1,2*" %%I IN ('REG QUERY HKLM\Software\7-Zip /V Path') DO (IF "%%I"=="Path" SET Zip=%%K7z.exe)
IF %PROCESSOR_ARCHITECTURE% EQU AMD64 (CALL :X64) ELSE (CALL :X86)
SET Installer=iTunes%Arch%Setup.exe
IF EXIST %Installer% GOTO :Extractor
CURL https://www.apple.com/itunes/download/win%Arch% --location --output %Installer%
:Extractor
MD %Unpack% 2>NUL
MD %Output% 2>NUL
"%Zip%" e -y %Installer% %iTunes%
MSIEXEC /A %iTunes% /QN TARGETDIR="%Unpack%"
COPY %Unpack%\iTunes\ASL.dll %Output%
COPY %Unpack%\iTunes\CoreAudioToolbox.dll %Output%
COPY %Unpack%\iTunes\CoreFoundation.dll %Output%
COPY %Unpack%\iTunes\icudt*.dll %Output%
COPY %Unpack%\iTunes\libdispatch.dll %Output%
COPY %Unpack%\iTunes\libicuin.dll %Output%
COPY %Unpack%\iTunes\libicuuc.dll %Output%
COPY %Unpack%\iTunes\objc.dll %Output%
DEL %iTunes% 2>NUL
DEL %Installer% 2>NUL
RD %Unpack% /S /Q 2>NUL
:Exit
TIMEOUT -T 5
EXIT
:X64
SET Arch=64
SET Output=iTunes64
SET iTunes=iTunes64.msi
SET Unpack=%CD%\.iTunes64
EXIT /B
:X86
SET Arch=32
SET Output=iTunes
SET iTunes=iTunes.msi
SET Unpack=%CD%\.iTunes
EXIT /B
