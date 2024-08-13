@echo off
:msedgemain
cls
title Manage Microsoft Edge
echo ==================================================================
echo 1. Bing Discovery Button
echo 2. Desktop Search Bar
echo 3. Alt + Tab Behavior
echo 4. User Profile Directory
echo 5. Browser Caches Directory
if exist "%~1" echo +. Return to Main Menu
echo ==================================================================
set /p submenu=^> 
if [%submenu%] equ [1] goto :msedgemenu1
if [%submenu%] equ [2] goto :msedgemenu2
if [%submenu%] equ [3] goto :msedgemenu3
if [%submenu%] equ [4] goto :msedgemenu4
if [%submenu%] equ [5] goto :msedgemenu5
if [%submenu%] equ [+] goto :manageback
goto :msedgemain
:msedgemenu1
cls
title Manage Bing Discovery Button - Microsoft Edge
echo ==================================================================
echo 0. Hide
echo 1. Show (Default)
echo +. Return to Upper Menu
echo ==================================================================
set /p function=^> 
if [%function%] equ [0] goto :msedgem1off
if [%function%] equ [1] goto :msedgem1on
if [%function%] equ [+] goto :msedgeback
goto :msedgemenu1
:msedgem1off
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "HubsSidebarEnabled"  /t "REG_DWORD" /d "0x00000000" /f
goto :msedgeback
:msedgem1on
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "HubsSidebarEnabled" /f
goto :msedgeback
:msedgemenu2
cls
title Manage Desktop Search Bar - Microsoft Edge
echo ==================================================================
echo 0. Hide
echo 1. Show (Default)
echo +. Return to Upper Menu
echo ==================================================================
set /p function=^> 
if [%function%] equ [0] goto :msedgem2off
if [%function%] equ [1] goto :msedgem2on
if [%function%] equ [+] goto :msedgeback
goto :msedgemenu2
:msedgem2off
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "WebWidgetAllowed"  /t "REG_DWORD" /d "0x00000000" /f
goto :msedgeback
:msedgem2on
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "WebWidgetAllowed" /f
goto :msedgeback
:msedgemenu3
cls
title Manage Alt + Tab Behavior - Microsoft Edge
echo ==================================================================
echo 0. Default
echo 1. Switch only via windows
echo +. Return to Main Menu
echo ==================================================================
set /p function=^> 
if [%function%] equ [0] goto :msedgem3off
if [%function%] equ [1] goto :msedgem3on
if [%function%] equ [+] goto :msedgeback
goto :msedgemenu3
:msedgem3off
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "MultiTaskingegmenu3Filter" /f
goto :msedgeback
:msedgem3on
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "MultiTaskingegmenu3Filter" /t "REG_DWORD" /d "0x00000003" /f
goto :msedgeback
:msedgemenu4
cls
title Manage User Profile Directory - Microsoft Edge
echo ==================================================================
echo 0. Default Directory
echo 1. Move to Documents
echo 2. Move to User Directory
echo +. Return to Main Menu
echo ==================================================================
set /p function=^> 
if [%function%] equ [0] goto :msedgem4off
if [%function%] equ [1] goto :msedgem4on
if [%function%] equ [2] goto :msedgem4sel
if [%function%] equ [+] goto :msedgeback
goto :msedgemenu4
:msedgem4off
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "UserDataDir" /f
goto :msedgeback
:msedgem4on
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "UserDataDir"  /t "REG_SZ" /d "%userprofile%\Documents\EdgeUserData" /f
goto :msedgeback
:msedgem4sel
call :foldersel
if not defined sub goto :msedgemenu4
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "UserDataDir"  /t "REG_SZ" /d "%function%" /f
goto :msedgeback
:msedgemenu5
cls
title Manage Browser Caches Directory - Microsoft Edge
echo ==================================================================
echo 0. Default Directory
echo 1. Move to RAMDISK
echo 2. Move to User Directory
echo +. Return to Main Menu
echo ==================================================================
set /p function=^> 
if [%function%] equ [0] goto :msedgem5off
if [%function%] equ [1] goto :msedgem5on
if [%function%] equ [2] goto :msedgem5sel
if [%function%] equ [+] goto :msedgeback
goto :msedgemenu5
:msedgem5off
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "DiskCacheDir" /f
goto :msedgeback
:msedgem5on
for /f %%a in ('wmic logicaldisk where "VolumeName='RAMDISK'" get Caption ^| find ":"') do (set ramdisk=%%a\Temp)
if not exist "%ramdisk%" goto :msedgemenu5
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "DiskCacheDir" /t "REG_SZ" /d "%ramdisk%" /f
:msedgem5sel
call :foldersel
if not defined sub goto :msedgemenu5
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "DiskCacheDir" /t "REG_SZ" /d "%function%" /f
goto :msedgeback
:foldersel
for /f "delims=" %%a in ('powershell -Command "Add-Type -AssemblyName System.windows.forms; $dialog = New-Object System.Windows.Forms.FolderBrowserDialog;$dialog.ShowDialog() | Out-Null;$dialog.SelectedPath"') do (set sub=%%a)
exit /b
:msedgeback
set submenu=
set function=
goto :msedgemain
:manageback
if exist "%~1" call "%~1"
goto :msedgemain
