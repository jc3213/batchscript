@echo off
set main="%~1"
set amdcpu=%systemroot%\System32\mcupdate_GenuineIntel.dll
set intlcpu=%systemroot%\System32\mcupdate_AuthenticAMD.dll
set microbk="%~dp0microcode_backup.zip"
:advanced
cls
title Windows Accessibility
echo ==================================================================
echo 1. Windows Picture Viewer
echo 2. Move Temporary Files to Ramdisk
echo 3. Context Menu (Windows 11)
echo 4. CPU Microcode Update
if exist %main% echo +. Return to  Main Menu
echo ==================================================================
set /p avact=^> 
if [%avact%] equ [1] goto :avmenu1
if [%avact%] equ [2] goto :avmenu2
if [%avact%] equ [3] goto :avmenu3
if [%avact%] equ [4] goto :avmenu4
if [%avact%] equ [+] goto :mainmenu
goto :advanced
:avmenu1
cls
title Windows Picture Viewer - Windows Accessibility
echo ==================================================================
echo Processing...
echo ==================================================================
call :avm1app1 bmp Bitmap
call :avm1app1 dib Bitmap
call :avm1app1 gif Gif
call :avm1app1 jfif JFIF
call :avm1app1 jpe Jpeg
call :avm1app1 jpeg Jpeg
call :avm1app1 jpg Jpeg
call :avm1app1 png Png
call :avm1app1 tiff Tiff
call :avm1app1 tif Tiff
call :avm1app1 wdp Wdp
call :avm1app2 Bitmap 70
call :avm1app2 JFIF 72
call :avm1app2 Jpeg 72
call :avm1app2 Png 71
call :avm1app2 Tiff 122
call :avm1app2 Wdp
call :avm1app4 Bitmap 6
call :avm1app4 JFIF 5
call :avm1app4 Jpeg 5
call :avm1app4 Png 7
call :avm1app4 Tiff 8
call :avm1app5 JFIF
call :avm1app5 Jpeg
call :avm1app5 Wdp
call :avm1app6 JFIF
call :avm1app6 Jpeg
call :avm1app6 Tiff
call :avm1app6 Wdp
goto :return
:avm1app1
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".%1" /t "REG_SZ" /d "PhotoViewer.FileAssoc.%2" /f
exit /b
:avm1app2
reg add "HKCR\PhotoViewer.FileAssoc.%1" /v "ImageOptionFlags" /t "REG_DWORD" /d "0x00000001" /f
reg add "HKCR\PhotoViewer.FileAssoc.%1\shell\open\command" /ve /t "REG_EXPAND_SZ" /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f
reg add "HKCR\PhotoViewer.FileAssoc.%1\shell\open\DropTarget" /v "Clsid" /t "REG_SZ" /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f
if %1 equ Wdp goto :avm1app3
reg add "HKCR\PhotoViewer.FileAssoc.%1\DefaultIcon" /ve /t "REG_SZ" /d "%%SystemRoot%%\System32\imageres.dll,-%2" /f
exit /b
:avm1app3
reg add "HKCR\PhotoViewer.FileAssoc.Wdp\DefaultIcon" /ve /t "REG_SZ" /d "%%SystemRoot%%\System32\wmphoto.dll,-400" /f
exit /b
:avm1app4
reg add "HKCR\PhotoViewer.FileAssoc.%1" /v "FriendlyTypeName" /t "REG_EXPAND_SZ" /d "@%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll,-305%2" /f
exit /b
:avm1app5
reg add "HKCR\PhotoViewer.FileAssoc.%1" /v "EditFlags" /t "REG_DWORD" /d "0x00010000" /f
exit /b
:avm1app6
reg add "HKCR\PhotoViewer.FileAssoc.%1\shell\open" /v "MuiVerb" /t "REG_EXPAND_SZ" /d "@%%ProgramFiles%%\Windows Photo Viewer\photoviewer.dll,-3043" /f
exit /b
:avmenu2
cls
title Move Temporary Files to Ramdisk - Windows Accessibility
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
title Context Menu (Windows 11) - Windows Accessibility
echo ==================================================================
echo 0. Modern Mode (Default)
echo 1. Legacy Mode
echo +. Return to Upper Menu
echo ==================================================================
set /p avsub=^> 
if [%avsub%] equ [0] goto :avm3off
if [%avsub%] equ [1] goto :avm3on
if [%avsub%] equ [+] goto :return
goto :avmenu3
:avm3off
reg delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f
goto :return
:avm3on
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /ve /d "" /f
goto :return
:avmenu4
cls
title CPU Microcode Update - Windows Accessibility
echo ==================================================================
echo 0. Restore from Backup
echo 1. Remove and Backup
echo +. Return to Upper Menu
echo ==================================================================
set /p avsub=^> 
if [%avsub%] equ [0] goto :avm4off
if [%avsub%] equ [1] goto :avm4on
if [%avsub%] equ [+] goto :return
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
