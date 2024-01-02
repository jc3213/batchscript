@echo off
pushd %~dp0
if %Processor_Architecture% equ AMD64 (set Arch=x64) else (set Arch=x86)
%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe -Command "Add-AppxPackage -Path 'Microsoft.VCLibs.140.00_14.0.30704.0_%Arch%__8wekyb3d8bbwe.Appx'"
timeout /t 5
