@echo off
set main="%~1"
:msedge
cls
title Manage Microsoft Edge
echo ==================================================================
echo 1. Bing Discovery Button
echo 2. Desktop Search Bar
echo 3. Alt + Tab Behavior
echo 4. User Profile Directory
echo 5. Browser Caches Directory
if exist %main% echo +. Return to  Main Menu
echo ==================================================================
set /p egact=^> 
if [%egact%] equ [1] goto :egmenu1
if [%egact%] equ [2] goto :egmenu2
if [%egact%] equ [3] goto :egmenu3
if [%egact%] equ [4] goto :egmenu4
if [%egact%] equ [5] goto :egmenu5
if [%egact%] equ [+] goto :mainmenu
goto :msedge
:egmenu1
cls
title Manage Bing Discovery Button - Microsoft Edge
echo ==================================================================
echo 0. Hide
echo 1. Show (Default)
echo +. Return to Upper Menu
echo ==================================================================
set /p egsub=^> 
if [%egsub%] equ [0] goto :edm1off
if [%egsub%] equ [1] goto :edm1on
if [%egsub%] equ [+] goto :return
goto :egmenu1
:edm1off
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "HubsSidebarEnabled"  /t "REG_DWORD" /d "0x00000000" /f
goto :return
:edm1on
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "HubsSidebarEnabled" /f
goto :return
:egmenu2
cls
title Manage Desktop Search Bar - Microsoft Edge
echo ==================================================================
echo 0. Hide
echo 1. Show (Default)
echo +. Return to Upper Menu
echo ==================================================================
set /p egsub=^> 
if [%egsub%] equ [0] goto :egm2off
if [%egsub%] equ [1] goto :egm2on
if [%egsub%] equ [+] goto :return
goto :egmenu2
:egm2off
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "WebWidgetAllowed"  /t "REG_DWORD" /d "0x00000000" /f
goto :return
:egm2on
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "WebWidgetAllowed" /f
goto :return
:egmenu3
cls
title Manage Alt + Tab Behavior - Microsoft Edge
echo ==================================================================
echo 0. Default
echo 1. Switch only via windows
echo +. Return to  Main Menu
echo ==================================================================
set /p egsub=^> 
if [%egsub%] equ [0] goto :egm3off
if [%egsub%] equ [1] goto :egm3on
if [%egsub%] equ [+] goto :return
goto :egmenu3
:egm3off
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "MultiTaskingegmenu3Filter" /f
goto :return
:egm3on
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "MultiTaskingegmenu3Filter" /t "REG_DWORD" /d "0x00000003" /f
goto :return
:egmenu4
cls
title Manage User Profile Directory - Microsoft Edge
echo ==================================================================
echo 0. Default
echo 1. Move to Documents
echo 2. Move to User Directory
echo +. Return to  Main Menu
echo ==================================================================
set /p egsub=^> 
if [%egsub%] equ [0] goto :egm4off
if [%egsub%] equ [1] call :egm4app "%UserProfile%\Documents\EdgeUserData"
if [%egsub%] equ [2] goto :egm4sel
if [%egsub%] equ [+] goto :return
goto :egmenu4
:egm4off
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "UserDataDir" /f
goto :return
:egm4sel
cls
echo ==================================================================
echo Sample: D:\EdgeUserData
echo ==================================================================
set /p egdir=^> 
if exist "%egdir%" call :egm4app "%egdir%"
goto :egmenu4
:egm4app
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "UserDataDir"  /t "REG_SZ" /d "%~1" /f
goto :return
:egmenu5
cls
title Manage Browser Caches Directory - Microsoft Edge
echo ==================================================================
echo 0. Default
echo 1. Move to RAMDISK
echo 2. Move to User Directory
echo +. Return to  Main Menu
echo ==================================================================
set /p egsub=^> 
if [%egsub%] equ [0] goto :egm5off
if [%egsub%] equ [1] goto :egm5on
if [%egsub%] equ [2] goto :egm5sel
if [%egsub%] equ [+] goto :return
goto :egmenu5
:egm5off
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "DiskCacheDir" /f
goto :return
:egm5on
for /f %%a in ('wmic logicaldisk where "VolumeName='RAMDISK'" get Caption ^| find ":"') do (set ramdisk=%%a\Temp)
if exist "%ramdisk%" call :egm5app "%ramdisk%"
:egm5sel
cls
echo ==================================================================
echo Sample: R:\Temp
echo ==================================================================
set /p egdir=^> 
if exist "%egdir%" call :egm5app "%egdir%"
goto :egmenu5
:egm5app
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "DiskCacheDir" /t "REG_SZ" /d "%~1" /f
goto :return
:mainmenu
if exist %main% call %main%
:return
set egact=
set egsub=
set egdir=
goto :msedge
