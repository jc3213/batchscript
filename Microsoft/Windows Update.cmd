@echo off
:updatemain
cls
title Manage Windows Update
echo ==================================================================
echo 1. Manage Auto Update
echo 2. Manage Driver Auto Update
echo 3. Manage Windows Update Service (wuauserv)
echo 4. Manage Malicious Software Removal Tool
if exist "%~1" echo +. Return to Main Menu
echo ==================================================================
set /p submenu=^> 
if [%submenu%] equ [1] goto :updatemenu1
if [%submenu%] equ [2] goto :updatemenu2
if [%submenu%] equ [3] goto :updatemenu3
if [%submenu%] equ [4] goto :updatemenu4
if [%submenu%] equ [+] goto :manageback
goto :updatemain
:updatemenu1
cls
title Auto Update - Windows Update
echo ==================================================================
echo 0. Disable
echo 1. Enable (Default)
echo +. Return to Upper Menu
echo ==================================================================
set /p function=^> 
if [%function%] equ [0] goto :updatem1off
if [%function%] equ [1] goto :updatem1on
if [%function%] equ [+] goto :updateback
goto :updatemenu1
:updatem1off
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t "REG_DWORD" /d "0x00000001" /f
goto :updateback
:updatem1on
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /f
goto :updateback
:updatemenu2
cls
title Driver Auto Update - Windows Update
echo ==================================================================
echo 0. Disable
echo 1. Enable (Default)
echo +. Return to Upper Menu
echo ==================================================================
set /p function=^> 
if [%function%] equ [0] goto :updatem2off
if [%function%] equ [1] goto :updatem2on
if [%function%] equ [+] goto :updateback
goto :updatemenu2
:updatem2off
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /t "REG_DWORD" /d "0x00000001" /f
goto :updateback
:updatem2on
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /f
goto :updateback
:updatemenu3
cls
title Windows Update Service - Windows Update
echo ==================================================================
echo 0. Disable
echo 1. Enable (Default)
echo +. Return to Upper Menu
echo ==================================================================
set /p function=^> 
if [%function%] equ [0] goto :updatem3off
if [%function%] equ [1] goto :updatem3on
if [%function%] equ [+] goto :updateback
goto :updatemenu3
:updatem3off
sc stop "wuauserv"
sc config "wuauserv" start=disabled
goto :updateback
:updatem3on
sc config "wuauserv" start=demand
sc start "wuauserv"
goto :updateback
:updatemenu4
cls
title Malicious Software Removal Tool - Windows Update
echo ==================================================================
echo 0. Disable
echo 1. Enable (Default)
echo +. Return to Upper Menu
echo ==================================================================
set /p function=^> 
if [%function%] equ [0] goto :updatem4off
if [%function%] equ [1] goto :updatem4on
if [%function%] equ [+] goto :updateback
goto :updatemenu4
:updatem4off
ren "%WinDir%\System32\MRT.exe" "MRT.nouse"
reg add "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v "DontOfferThroughWUAU" /t "REG_DWORD" /d "0x00000001" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v "DontReportInfectionInformation" /t "REG_DWORD" /d "0x00000001" /f
goto :updateback
:updatem4on
ren "%WinDir%\System32\MRT.nouse" "MRT.exe"
reg delete "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v "DontOfferThroughWUAU" /f
reg delete "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v "DontReportInfectionInformatio" /f
goto :updateback
:updateback
set submenu=
set function=
goto :updatemain
:manageback
if exist "%~1" call "%~1"
goto :updatemain
