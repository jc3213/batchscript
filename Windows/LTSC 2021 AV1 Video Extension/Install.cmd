@ECHO OFF
PUSHD %~DP0
IF %PROCESSOR_ARCHITECTURE% EQU AMD64 (SET Arch=x64) ELSE (SET Arch=x86)
%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe -Command "Add-AppxPackage -Path 'Microsoft.AV1VideoExtension_1.1.52851.0_%Arch%__8wekyb3d8bbwe.Appx'"
TIMEOUT /T 5
