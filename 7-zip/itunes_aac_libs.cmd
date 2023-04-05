@ECHO OFF
PUSHD %~DP0
FOR /F "tokens=1,2*" %%I IN ('REG QUERY HKLM\Software\7-Zip /V Path') DO (IF "%%I"=="Path" SET Zip=%%K7z.exe)
IF NOT EXIST "%Zip%" GOTO :Exit
IF %PROCESSOR_ARCHITECTURE% EQU AMD64 (SET Arch=64) ELSE (SET Arch=32)
SET File=%~NX1
IF EXIST "%File%" GOTO :Extractor
SET File=iTunes%Arch%Setup.exe
IF EXIST %File% GOTO :Extractor
CURL https://www.apple.com/itunes/download/win%Arch% --location --output %File%
:Extractor
SET Output=iTunes%Arch%
SET iTunes=iTunes%Arch%.msi
SET Unpack=%CD%\.Unpacked
MD %Unpack% 2>NUL
MD %Output% 2>NUL
"%Zip%" e -y %File% %iTunes%
MSIEXEC /A %iTunes% /QN TARGETDIR="%Unpack%"
COPY %Unpack%\iTunes\ASL.dll %Output%
COPY %Unpack%\iTunes\CoreAudioToolbox.dll %Output%
COPY %Unpack%\iTunes\CoreFoundation.dll %Output%
COPY %Unpack%\iTunes\icudt*.dll %Output%
COPY %Unpack%\iTunes\libdispatch.dll %Output%
COPY %Unpack%\iTunes\libicuin.dll %Output%
COPY %Unpack%\iTunes\libicuuc.dll %Output%
COPY %Unpack%\iTunes\objc.dll %Output%
RD %Unpack% /S /Q 2>NUL
DEL %Pack% 2>NUL
:Exit
TIMEOUT -T 5
