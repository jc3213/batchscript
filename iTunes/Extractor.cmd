@ECHO OFF
PUSHD %~DP0
FOR /F "tokens=1,2*" %%I IN ('REG QUERY HKLM\Software\7-Zip /V Path') DO (IF "%%I"=="Path" SET Zip=%%K7z.exe)
IF EXIST "%Zip%" GOTO :File
IF NOT EXIST 7za.exe GOTO :Exit
IF NOT EXIST 7za.dll GOTO :Exit
SET Zip=7za.exe
:File
IF "%1"=="" GOTO :Input
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
COPY %Unpack%\iTunes\objc.dll %Name%
COPY %Unpack%\iTunes\pthreadVC2.dll %Name%
RD %Unpack% /S /Q 2>NUL
DEL %Pack% 2>NUL
:Exit
TIMEOUT -T 5
