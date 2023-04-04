@ECHO OFF
PUSHD %~DP0
FOR /F "tokens=1,2*" %%I IN ('REG QUERY HKLM\Software\7-Zip /V Path') DO (IF "%%I"=="Path" SET Zip=%%K7z.exe)
IF NOT EXIST "%Zip%" GOTO :Exit
:File
IF NOT EXIST "%~1" GOTO :Input
SET File=%1
SET Name=%~N1
GOTO :Unpack
:Input
SET /P File=Select iTunes Installer: 
IF NOT EXIST "%File%" GOTO :Input
CALL :File %File%
:Unpack
SET Name=%Name:Setup=%
SET Pack=%Name%.msi
SET Unpack=%CD%\.Unpacked
"%Zip%" e -y "%File%" %Pack%
MD %Name% 2>NUL
MSIEXEC /A %Pack% /Q TARGETDIR=%Unpack%
COPY %Unpack%\iTunes\ASL.dll %Name%
COPY %Unpack%\iTunes\CoreAudioToolbox.dll %Name%
COPY %Unpack%\iTunes\CoreFoundation.dll %Name%
COPY %Unpack%\iTunes\icudt*.dll %Name%
COPY %Unpack%\iTunes\libdispatch.dll %Name%
COPY %Unpack%\iTunes\libicuin.dll %Name%
COPY %Unpack%\iTunes\libicuuc.dll %Name%
COPY %Unpack%\iTunes\objc.dll %Name%
RD %Unpack% /S /Q 2>NUL
DEL %Pack% 2>NUL
:Exit
TIMEOUT -T 5
