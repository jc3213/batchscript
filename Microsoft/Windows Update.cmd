@echo off
set main="%~1"
:winupdate
cls
title Manage Windows Update
echo ==================================================================
echo 1. Manage Auto Update
echo 2. Manage Driver Auto Update
echo 3. Manage Windows Update Service (wuauserv)
if exist %main% echo +. Return Main Menu
echo ==================================================================
set /p wuact=^> 
if [%wuact%] equ [1] goto :wumenu1
if [%wuact%] equ [2] goto :wumenu2
if [%wuact%] equ [3] goto :wumenu3
if [%wuact%] equ [+] goto :mainmenu
goto :winupdate
:wumenu1
cls
title Auto Update - Windows Update
echo ==================================================================
echo 0. Disable
echo 1. Enable (Default)
echo +. Return Upper Menu
echo ==================================================================
set /p wusub=^> 
if [%wusub%] equ [0] goto :wum1off
if [%wusub%] equ [1] goto :wum1on
if [%wusub%] equ [+] goto :return
goto :wumenu1
:wum1off
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t "REG_DWORD" /d "0x00000001" /f
goto :return
:wum1on
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /f
goto :return
:wumenu2
cls
title Driver Auto Update - Windows Update
echo ==================================================================
echo 0. Disable
echo 1. Enable (Default)
echo +. Return Upper Menu
echo ==================================================================
set /p wusub=^> 
if [%wusub%] equ [0] goto :wum2off
if [%wusub%] equ [1] goto :wum2on
if [%wusub%] equ [+] goto :return
goto :wumenu2
:wum2off
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /t "REG_DWORD" /d "0x00000001" /f
goto :return
:wum2on
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /f
goto :return
:wumenu3
cls
title Windows Update Service - Windows Update
echo ==================================================================
echo 0. Disable
echo 1. Enable (Default)
echo +. Return Upper Menu
echo ==================================================================
set /p wusub=^> 
if [%wusub%] equ [0] goto :wum3off
if [%wusub%] equ [1] goto :wum3on
if [%wusub%] equ [+] goto :return
goto :wumenu3
:wum3off
sc stop "wuauserv"
sc config "wuauserv" start=disabled
goto :return
:wum3on
sc config "wuauserv" start=demand
sc start "wuauserv"
goto :return
:mainmenu
if exist %main% call %main%
:return
set wuact=
set wusub=
goto :winupdate
