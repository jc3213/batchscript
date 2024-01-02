@echo off
pushd %~dp0
if %Processor_Architecture% equ AMD64 (set Arch=x64) else (set Arch=x86)
%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe -Command "Add-AppxPackage -Path 'Microsoft.AV1VideoExtension_1.1.52851.0_%Arch%__8wekyb3d8bbwe.Appx'"
timeout /t 5
