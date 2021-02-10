@ECHO OFF
IF EXIST 7z.exe GOTO :File
FOR /F "tokens=1,2*" %%I IN ('REG QUERY HKLM\Software\7-Zip /V Path') DO (
    IF "%%I"=="Path" PUSHD %%K
)
IF NOT EXIST 7z.exe GOTO :Error
:File
IF "%1"=="" GOTO :Input
SET File=%1
SET Name=%~N1
GOTO :Unpack
:Input
SET /P File=Select iTunes Installer: 
IF NOT EXIST %File% GOTO :Input
CALL :File %File%
:Unpack
SET Name=%Name:Setup=%
SET Pack=%Name%.msi
7z.exe e -y "%File%" %Pack% -o%~DP1
:Extract
MD %~DP1%Name% 2>NUL
MSIEXEC /A %~DP1%Pack% /Q TARGETDIR=%~DP1.Unpacked
COPY %~DP1.Unpacked\iTunes\ASL.dll %~DP1%Name%
COPY %~DP1.Unpacked\iTunes\CoreAudioToolbox.dll %~DP1%Name%
COPY %~DP1.Unpacked\iTunes\CoreFoundation.dll %~DP1%Name%
COPY %~DP1.Unpacked\iTunes\icudt*.dll %~DP1%Name%
COPY %~DP1.Unpacked\iTunes\libdispatch.dll %~DP1%Name%
COPY %~DP1.Unpacked\iTunes\objc.dll %~DP1%Name%
COPY %~DP1.Unpacked\iTunes\pthreadVC2.dll %~DP1%Name%
RD %~DP1.Unpacked /S /Q 2>NUL
DEL %~DP1%Pack% 2>NUL
:Error
EXIT
