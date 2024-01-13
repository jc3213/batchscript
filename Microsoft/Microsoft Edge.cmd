@echo off
:edgemain
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
set /p edgemain=^> 
if [%edgemain%] equ [1] goto :edgemenu1
if [%edgemain%] equ [2] goto :edgemenu2
if [%edgemain%] equ [3] goto :edgemenu3
if [%edgemain%] equ [4] goto :edgemenu4
if [%edgemain%] equ [5] goto :edgemenu5
if [%edgemain%] equ [+] goto :backmain
goto :edgemain
:edgemenu1
cls
title Manage Bing Discovery Button - Microsoft Edge
echo ==================================================================
echo 0. Hide
echo 1. Show (Default)
echo +. Return to Upper Menu
echo ==================================================================
set /p edgesub=^> 
if [%edgesub%] equ [0] goto :edgem1off
if [%edgesub%] equ [1] goto :edgem1on
if [%edgesub%] equ [+] goto :edgeback
goto :edgemenu1
:edgem1off
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "HubsSidebarEnabled"  /t "REG_DWORD" /d "0x00000000" /f
goto :edgeback
:edgem1on
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "HubsSidebarEnabled" /f
goto :edgeback
:edgemenu2
cls
title Manage Desktop Search Bar - Microsoft Edge
echo ==================================================================
echo 0. Hide
echo 1. Show (Default)
echo +. Return to Upper Menu
echo ==================================================================
set /p edgesub=^> 
if [%edgesub%] equ [0] goto :edgem2off
if [%edgesub%] equ [1] goto :edgem2on
if [%edgesub%] equ [+] goto :edgeback
goto :edgemenu2
:edgem2off
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "WebWidgetAllowed"  /t "REG_DWORD" /d "0x00000000" /f
goto :edgeback
:edgem2on
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "WebWidgetAllowed" /f
goto :edgeback
:edgemenu3
cls
title Manage Alt + Tab Behavior - Microsoft Edge
echo ==================================================================
echo 0. Default
echo 1. Switch only via windows
echo +. Return to Main Menu
echo ==================================================================
set /p edgesub=^> 
if [%edgesub%] equ [0] goto :edgem3off
if [%edgesub%] equ [1] goto :edgem3on
if [%edgesub%] equ [+] goto :edgeback
goto :edgemenu3
:edgem3off
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "MultiTaskingegmenu3Filter" /f
goto :edgeback
:edgem3on
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "MultiTaskingegmenu3Filter" /t "REG_DWORD" /d "0x00000003" /f
goto :edgeback
:edgemenu4
cls
title Manage User Profile Directory - Microsoft Edge
echo ==================================================================
echo 0. Default Directory
echo 1. Move to Documents
echo 2. Move to User Directory
echo +. Return to Main Menu
echo ==================================================================
set /p edgesub=^> 
if [%edgesub%] equ [0] goto :edgem4off
if [%edgesub%] equ [1] goto :edgem4on
if [%edgesub%] equ [2] goto :edgem4sel
if [%edgesub%] equ [+] goto :edgeback
goto :edgemenu4
:edgem4off
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "UserDataDir" /f
goto :edgeback
:edgem4on
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "UserDataDir"  /t "REG_SZ" /d "%userprofile%\Documents\EdgeUserData" /f
goto :edgeback
:edgem4sel
call :edgefolder
if not defined edgesub goto :edgemenu4
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "UserDataDir"  /t "REG_SZ" /d "%edgesub%" /f
goto :edgeback
:edgemenu5
cls
title Manage Browser Caches Directory - Microsoft Edge
echo ==================================================================
echo 0. Default Directory
echo 1. Move to RAMDISK
echo 2. Move to User Directory
echo +. Return to Main Menu
echo ==================================================================
set /p edgesub=^> 
if [%edgesub%] equ [0] goto :edgem5off
if [%edgesub%] equ [1] goto :edgem5on
if [%edgesub%] equ [2] goto :edgem5sel
if [%edgesub%] equ [+] goto :edgeback
goto :edgemenu5
:edgem5off
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "DiskCacheDir" /f
goto :edgeback
:edgem5on
for /f %%a in ('wmic logicaldisk where "VolumeName='RAMDISK'" get Caption ^| find ":"') do (set ramdisk=%%a\Temp)
if not exist "%ramdisk%" goto :edgemenu5
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "DiskCacheDir" /t "REG_SZ" /d "%ramdisk%" /f
:edgem5sel
call :edgefolder
if not defined edgesub goto :edgemenu5
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "DiskCacheDir" /t "REG_SZ" /d "%edgesub%" /f
goto :edgeback
:edgefolder
for /f "delims=" %%a in ('powershell -Command "Add-Type -AssemblyName System.windows.forms; $dialog = New-Object System.Windows.Forms.FolderBrowserDialog;$dialog.ShowDialog() | Out-Null;$dialog.SelectedPath"') do (set edgesub=%%a)
exit /b
:edgeback
set edgemain=
set edgesub=
timeout /t 5
goto :edgemain
:backmain
if exist "%~1" call "%~1"
goto :edgemain
