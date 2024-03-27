@echo off
set amdcpu=%systemroot%\System32\mcupdate_GenuineIntel.dll
set intlcpu=%systemroot%\System32\mcupdate_AuthenticAMD.dll
set cpuback="%~dp0microcode_backup.zip"
:miscmain
cls
title Windows Accessibility
echo ==================================================================
echo 1. Windows Picture Viewer
echo 2. Move Temporary Files to Ramdisk
echo 3. Move User Profile Data
echo 4. Context Menu (Windows 11)
echo 5. CPU Microcode Update
if exist "%~1" echo +. Return to Main Menu
echo ==================================================================
set /p miscact=^> 
if [%miscact%] equ [1] goto :miscmenu1
if [%miscact%] equ [2] goto :miscmenu2
if [%miscact%] equ [3] goto :miscmenu3
if [%miscact%] equ [4] goto :miscmenu4
if [%miscact%] equ [5] goto :miscmenu5
if [%miscact%] equ [+] goto :backmain
goto :miscmain
:miscmenu1
cls
title Windows Picture Viewer - Windows Accessibility
echo ==================================================================
echo Processing...
echo ==================================================================
set viewasso="bmp Bitmap" "dib Bitmap" "gif Gif" "jfif JFIF" "jpe Jpeg" "jpeg Jpeg" "jpg Jpeg" "png Png" "tiff Tiff" "tif Tiff" "wdp Wdp"
for %%a in (%viewasso%) do (for /f "tokens=1-2 delims= " %%i in (%%a) do (call :miscm1asso %%i %%j))
set viewcomm="Bitmap imageres 70" "JFIF imageres 72" "Jpeg imageres 72" "Png imageres 71" "Tiff imageres 122" "Wdp wmphoto -400"
for %%a in (%viewcomm%) do (for /f "tokens=1-3 delims= " %%i in (%%a) do (call :miscm1comm %%i %%j %%k))
set viewname="Bitmap 6" "JFIF 5" "Jpeg 5" "Png 7" "Tiff 8"
for %%a in (%viewname%) do (for /f "tokens=1-2 delims= " %%i in (%%a) do (call :miscm1name %%i %%j))
for %%a in (JFIF Jpeg Wdp) do (call :miscm1edit %%a)
for %%a in (JFIF Jpeg Tiff Wdp) do (call :miscm1open %%a)
goto :miscback
:miscm1asso
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".%1" /t "REG_SZ" /d "PhotoViewer.FileAssoc.%2" /f
exit /b
:miscm1comm
reg add "HKCR\PhotoViewer.FileAssoc.%1" /v "ImageOptionFlags" /t "REG_DWORD" /d "0x00000001" /f
reg add "HKCR\PhotoViewer.FileAssoc.%1\shell\open\command" /ve /t "REG_EXPAND_SZ" /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f
reg add "HKCR\PhotoViewer.FileAssoc.%1\shell\open\DropTarget" /v "Clsid" /t "REG_SZ" /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f
reg add "HKCR\PhotoViewer.FileAssoc.%1\DefaultIcon" /ve /t "REG_SZ" /d "%%SystemRoot%%\System32\%2.dll,%3" /f
exit /b
:miscm1name
reg add "HKCR\PhotoViewer.FileAssoc.%1" /v "FriendlyTypeName" /t "REG_EXPAND_SZ" /d "@%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll,-305%2" /f
exit /b
:miscm1edit
reg add "HKCR\PhotoViewer.FileAssoc.%1" /v "EditFlags" /t "REG_DWORD" /d "0x00010000" /f
exit /b
:miscm1open
reg add "HKCR\PhotoViewer.FileAssoc.%1\shell\open" /v "MuiVerb" /t "REG_EXPAND_SZ" /d "@%%ProgramFiles%%\Windows Photo Viewer\photoviewer.dll,-3043" /f
exit /b
:miscmenu2
cls
title Move Temporary Files to Ramdisk - Windows Accessibility
echo ==================================================================
echo Processing...
echo ==================================================================
for /f %%a in ('wmic logicaldisk where "VolumeName='RAMDISK'" get Caption ^| find ":"') do (set ramdisk=%%a\Temp)
if not exist "%ramdisk%" goto :miscback
call :symboforce "%localappdata%\Temp" "%ramdisk%"
call :symboforce "%systemroot%\Temp" "%ramdisk%"
goto :miscback
:miscmenu3
cls
title Move User Profile Data - Windows Accessibility
echo ==================================================================
echo Pleas enter the disk label
echo For example, D or D: or D:\
echo ==================================================================
set /p miscsub=^> 
set drive=%miscsub:~0,1%:
if not exist "%drive%" goto :miscback
call :symbolink "%UserProfile%\Desktop" "%drive%\Home\Desktop"
call :symbolink "%UserProfile%\Documents" "%drive%\Home\Documents"
call :symbolink "%UserProfile%\Downloads" "%drive%\Home\Downloads"
call :symbolink "%UserProfile%\Music" "%drive%\Home\Music"
call :symbolink "%UserProfile%\Pictures" "%drive%\Home\Pictures"
call :symbolink "%UserProfile%\Saved Games" "%drive%\Home\Saved Games"
call :symbolink "%UserProfile%\Videos" "%drive%\Home\Videos"
goto :miscback
:miscmenu4
cls
title Context Menu (Windows 11) - Windows Accessibility
echo ==================================================================
echo 0. Modern Mode (Default)
echo 1. Legacy Mode
echo +. Return to Upper Menu
echo ==================================================================
set /p miscsub=^> 
if [%miscsub%] equ [0] goto :miscm4off
if [%miscsub%] equ [1] goto :miscm4on
if [%miscsub%] equ [+] goto :miscback
goto :miscmenu4
:miscm4off
reg delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f
goto :miscback
:miscm4on
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /ve /d "" /f
goto :miscback
:miscmenu5
cls
title CPU Microcode Update - Windows Accessibility
echo ==================================================================
echo 0. Restore from Backup
echo 1. Remove and Backup
echo +. Return to Upper Menu
echo ==================================================================
set /p miscsub=^> 
if [%miscsub%] equ [0] goto :miscm5off
if [%miscsub%] equ [1] goto :miscm5on
if [%miscsub%] equ [+] goto :miscback
goto :miscmenu5
:miscm5off
if not exist "%cpuback%" goto :miscback
powershell -Command "Expand-Archive -Force -Path '%cpuback%' -DestinationPath '%systemroot%\System32'"
goto :miscback
:miscm5on
takeown /f "%amdcpu%" && "icacls %amdcpu%" /grant Administrators:F
takeown /f "%intlcpu%" && "icacls %intlcpu%" /grant Administrators:F
powershell -Command "Compress-Archive -Force -Path '%amdcpu%','%intlcpu%' -DestinationPath '%cpuback%'"
del "%amdcpu%" "%intlcpu%" /f /q
goto :miscback
:symbolink
if not exist "%~1" goto :symbomake
rd %1 2>nul && goto :symbomake
xcopy %1 %2 /e /i /h
:symboforce
rd %1 /s /q
:symbomake
mklink /d %1 "%drive%\Home\%~n1"
exit /b
:miscback
set miscact=
set miscsub=
timeout /t 5
goto :miscmain
:backmain
if exist "%~1" call "%~1"
goto :miscmain
