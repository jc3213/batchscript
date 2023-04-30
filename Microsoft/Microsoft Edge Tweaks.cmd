@echo off
:main
title Microsoft Edge Tweaks
echo ==================================================================
echo 1. Bing discovery button
echo 2. Desktop search bar
echo 3. Alt + Tab behavior
echo 4. Manage user profile
echo 5. Manage browser caches
echo ==================================================================
set /p main=^> 
if [%main%] equ [1] goto :bingbn
if [%main%] equ [2] goto :search
if [%main%] equ [3] goto :alttab
if [%main%] equ [4] goto :profile
if [%main%] equ [5] goto :caches
goto :back
:bingbn
cls
title Tweak Discovery Button
echo ==================================================================
echo 1. Disable discovery button
echo 2. Restore discovery button
echo 0. Back to main menu
echo ==================================================================
set /p btn=^> 
if [%btn%] equ [1] goto :btnoff
if [%btn%] equ [2] goto :btnbak
if [%btn%] equ [0] goto :back
goto :bingbn
:btnoff
echo.
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "HubsSidebarEnabled"  /t "REG_DWORD" /d "0x00000000" /f
goto :clear
:btnbak
echo.
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "HubsSidebarEnabled" /f
goto :clear
:search
cls
title Tweak Desktop Search Bar
echo ==================================================================
echo 1. Disable desktop search bar
echo 2. Restore desktop search bar
echo 0. Back to main menu
echo ==================================================================
set /p bar=^> 
if [%bar%] equ [1] goto :baroff
if [%bar%] equ [2] goto :barbak
if [%bar%] equ [0] goto :back
goto :search
:baroff
echo.
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "WebWidgetAllowed"  /t "REG_DWORD" /d "0x00000000" /f
goto :clear
:barbak
echo.
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "WebWidgetAllowed" /f
goto :clear
:alttab
cls
title Change Alt + Tab Behavior
echo ==================================================================
echo 1. Switch only via windows
echo 2. Restore default behavior
echo 0. Back to main menu
echo ==================================================================
set /p alt=^> 
if [%alt%] equ [1] goto :altoff
if [%alt%] equ [2] goto :altbak
if [%alt%] equ [0] goto :back
goto :alttab
:altoff
echo.
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "MultiTaskingAltTabFilter" /t "REG_DWORD" /d "0x00000003" /f
goto :clear
:altbak
echo.
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "MultiTaskingAltTabFilter" /f
goto :clear
:profile
cls
title Manage User Profile
echo ==================================================================
echo 1. Move to user documents
echo 2. User defined folder
echo 3. Restore default folder
echo 0. Back to main menu
echo ==================================================================
set /p pro=^> 
if [%pro%] equ [1] goto :prodoc
if [%pro%] equ [2] goto :prodef
if [%pro%] equ [3] goto :probak
if [%pro%] equ [0] goto :back
goto :profile
:prodoc
echo.
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "UserDataDir"  /t "REG_SZ" /d "%UserProfile%\Documents\EdgeUserData" /f
goto :clear
:probak
echo.
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "UserDataDir" /f
goto :clear
:prodef
cls
echo ==================================================================
echo Sample: D:\EdgeUserData
echo ==================================================================
set /p pdir=^> 
if exist "%pdir%" goto :prodir
echo.
echo %pdir% is not a valid path
set pro=
set pdir=
goto :profile
:prodir
echo.
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "UserDataDir"  /t "REG_SZ" /d "%pdir%" /f
goto :clear
@echo off
:caches
cls
title Manage Browser Caches
echo ==================================================================
echo 1. Move to RAMDISK
echo 2. User defined folder
echo 3. Restore default folder
echo 0. Back to main menu
echo ==================================================================
set /p csh=^> 
if [%csh%] equ [1] goto :cshram
if [%csh%] equ [2] goto :cshdef
if [%csh%] equ [3] goto :cshbak
if [%csh%] equ [0] goto :back
goto :caches
:cshram
for /f %%a in ('wmic logicaldisk where "VolumeName='RAMDISK'" get Caption ^| find ":"') do (set Ramdisk=%%a\Temp)
if exist "%Ramdisk%" goto :cshset
echo No RAMDISK detected!
goto :clear
:cshset
echo.
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "DiskCacheDir" /t "REG_SZ" /d "%Ramdisk%" /f
goto :clear
:cshbak
echo.
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "DiskCacheDir" /f
goto :clear
:cshdef
echo.
echo ==================================================================
echo Sample: R:\Temp
echo ==================================================================
set /p cdir=^> 
if exist "%cdir%" goto :cshdir
echo.
echo %cdir% is not a valid path
set csh=
set cdir=
goto :caches
:cshdir
echo.
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "DiskCacheDir" /t "REG_SZ" /d "%cdir%" /f
goto :clear
:clear
echo.
pause
:back
set main=
set btn=
set bar=
set alt=
set pro=
set pdir=
set csh=
set cdir=
cls
goto :main
