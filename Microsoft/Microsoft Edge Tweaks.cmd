@echo off
:main
cls
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
goto :main
:bingbn
cls
title Tweak Discovery Button
echo ==================================================================
echo 1. Disable discovery button
echo 2. Restore discovery button
echo 0. Back to main menu
echo ==================================================================
set /p act=^> 
echo.
if [%act%] equ [1] goto :btnoff
if [%act%] equ [2] goto :btnbak
if [%act%] equ [0] goto :back
goto :bingbn
:btnoff
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "HubsSidebarEnabled"  /t "REG_DWORD" /d "0x00000000" /f
goto :done
:btnbak
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "HubsSidebarEnabled" /f
goto :done
:search
cls
title Tweak Desktop Search Bar
echo ==================================================================
echo 1. Disable desktop search bar
echo 2. Restore desktop search bar
echo 0. Back to main menu
echo ==================================================================
set /p act=^> 
echo.
if [%act%] equ [1] goto :baroff
if [%act%] equ [2] goto :barbak
if [%act%] equ [0] goto :back
goto :search
:baroff
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "WebWidgetAllowed"  /t "REG_DWORD" /d "0x00000000" /f
goto :done
:barbak
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "WebWidgetAllowed" /f
goto :done
:alttab
cls
title Change Alt + Tab Behavior
echo ==================================================================
echo 1. Switch only via windows
echo 2. Restore default behavior
echo 0. Back to main menu
echo ==================================================================
set /p act=^> 
echo.
if [%act%] equ [1] goto :altoff
if [%act%] equ [2] goto :altbak
if [%act%] equ [0] goto :back
goto :alttab
:altoff
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "MultiTaskingAltTabFilter" /t "REG_DWORD" /d "0x00000003" /f
goto :done
:altbak
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "MultiTaskingAltTabFilter" /f
goto :done
:profile
cls
title Manage User Profile
echo ==================================================================
echo 1. Move to user documents
echo 2. User defined folder
echo 3. Restore default folder
echo 0. Back to main menu
echo ==================================================================
set /p act=^> 
echo.
if [%act%] equ [1] goto :prodoc
if [%act%] equ [2] goto :prodef
if [%act%] equ [3] goto :probak
if [%act%] equ [0] goto :back
goto :profile
:prodoc
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "UserDataDir"  /t "REG_SZ" /d "%UserProfile%\Documents\EdgeUserData" /f
goto :done
:probak
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "UserDataDir" /f
goto :done
:prodef
cls
echo ==================================================================
echo Sample: D:\EdgeUserData
echo ==================================================================
set /p fod=^> 
echo.
if exist "%fod%" goto :prodir
echo %fod% is not a valid path
set act=
set fod=
goto :profile
:prodir
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "UserDataDir"  /t "REG_SZ" /d "%fod%" /f
goto :done
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
set /p act=^> 
echo.
if [%act%] equ [1] goto :cshram
if [%act%] equ [2] goto :cshdef
if [%act%] equ [3] goto :cshbak
if [%act%] equ [0] goto :back
goto :caches
:cshram
for /f %%a in ('wmic logicaldisk where "VolumeName='RAMDISK'" get Caption ^| find ":"') do (set Ramdisk=%%a\Temp)
if exist "%Ramdisk%" goto :cshset
echo No RAMDISK detected!
goto :done
:cshset
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "DiskCacheDir" /t "REG_SZ" /d "%Ramdisk%" /f
goto :done
:cshbak
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "DiskCacheDir" /f
goto :done
:cshdef
echo ==================================================================
echo Sample: R:\Temp
echo ==================================================================
set /p fod=^> 
echo.
if exist "%fod%" goto :cshdir
echo %fod% is not a valid path
set act=
set fod=
goto :caches
:cshdir
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "DiskCacheDir" /t "REG_SZ" /d "%fod%" /f
goto :done
:done
echo.
pause
:back
set main=
set act=
set fod=
goto :main
