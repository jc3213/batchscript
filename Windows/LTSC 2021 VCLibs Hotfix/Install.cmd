@ECHO OFF
PUSHD %~DP0
IF EXIST "%SystemRoot%\SysWOW64" (SET Arch=x64) ELSE (SET Arch=x86)
%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe -Command "Add-AppxPackage -Path 'Microsoft.VCLibs.140.00_14.0.30704.0_%Arch%__8wekyb3d8bbwe.Appx'"
TIMEOUT /T 5
