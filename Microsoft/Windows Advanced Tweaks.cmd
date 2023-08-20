@echo off
set main="%~1"
set amdcpu=%systemroot%\System32\mcupdate_GenuineIntel.dll
set intlcpu=%systemroot%\System32\mcupdate_AuthenticAMD.dll
set microbk="%~dp0microcode_backup.zip"
:advanced
cls
title Windows Advanced Tweaks
echo ==================================================================
echo 1. Windows Picture Viewer
echo 2. Move Temporary Files to Ramdisk
echo 3. Context Menu (Windows 11)
echo 4. CPU Microcode Update
if exist %main% echo *. Back to main menu
echo ==================================================================
set /p avact=^> 
if [%avact%] equ [1] goto :avmenu1
if [%avact%] equ [2] goto :avmenu2
if [%avact%] equ [3] goto :avmenu3
if [%avact%] equ [4] goto :avmenu4
if [%avact%] equ [*] goto :mainmenu
goto :advanced
:avmenu1
cls
title Windows Picture Viewer - Advanced Tweaks
echo ==================================================================
echo Under development...
echo ==================================================================
pause
goto :return
:avmenu2
cls
title Move Temporary Files to Ramdisk - Advanced Tweaks
echo ==================================================================
echo Processing...
echo ==================================================================
for /f %%a in ('wmic logicaldisk where "VolumeName='RAMDISK'" get Caption ^| find ":"') do (set ramdisk=%%a\Temp)
if not exist "%ramdisk%" goto :return
rd /s /q "%localappdata%\Temp"
rd /s /q "%systemroot%\Temp"
mklink /d "%localappdata%\Temp" "%ramdisk%"
mklink /d "%systemroot%\Temp" "%ramdisk%"
goto :return
:avmenu3
cls
title Context Menu (Windows 11) - Advanced Tweaks
echo ==================================================================
echo 0. Modern Mode (Default)
echo 1. Legacy Mode
echo *. Return to upper menu
echo ==================================================================
set /p avsub=^> 
if [%avsub%] equ [0] goto :avm3off
if [%avsub%] equ [1] goto :avm3on
if [%avsub%] equ [*] goto :return
goto :avmenu3
:avm3off
reg delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f
goto :return
:avm3on
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /ve /d "" /f
goto :return
:avmenu4
cls
title CPU Microcode Update - Advanced Tweaks
echo ==================================================================
echo 0. Restore from Backup
echo 1. Remove and Backup
echo *. Return to upper menu
echo ==================================================================
set /p avsub=^> 
if [%avsub%] equ [0] goto :avm4off
if [%avsub%] equ [1] goto :avm4on
if [%avsub%] equ [*] goto :return
goto :avmenu4
:avm4off
if not exist %microbk% goto :return
powershell -Command "Expand-Archive -Force -Path '%microbk%' -DestinationPath '%systemroot%\System32'"
goto :return
:avm4on
takeown /f %amdcpu% && icacls %amdcpu% /grant Administrators:F
takeown /f %intlcpu% && icacls %intlcpu% /grant Administrators:F
powershell -Command "Compress-Archive -Force -Path '%amdcpu%','%intlcpu%' -DestinationPath '%microbk%'"
del "%amdcpu%" "%intlcpu%" /f /q
goto :return
:mainmenu
if exist %main% call %main%
:return
set avact=
set avsub=
goto :advanced
