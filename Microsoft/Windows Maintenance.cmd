@echo off
:advancemain
cls
title Manage Windows Maintenance
echo ==================================================================
echo 1. Manage Super Prefetch
echo 2. Manage Disk Defragment
echo 3. Manage Diagnostic
echo 4. Manage Auto Maintenance
if exist "%~1" echo +. Return to Main Menu
echo ==================================================================
set /p sec=^> 
if [%sec%] equ [1] goto :advancemenu1
if [%sec%] equ [2] goto :advancemenu2
if [%sec%] equ [3] goto :advancemenu3
if [%sec%] equ [4] goto :advancemenu4
if [%sec%] equ [+] goto :manageback
goto :advancemain
:advancemenu1
cls
title Super Prefetch - Windows Maintenance
echo ==================================================================
echo 0. Disable
echo 1. Enable (Default)
echo +. Return to Upper Menu
echo ==================================================================
set /p sub=^> 
if [%sub%] equ [0] goto :advancem1off
if [%sub%] equ [1] goto :advancem1on
if [%sub%] equ [+] goto :advanceback
goto :advancemenu1
:advancem1off
sc stop "SysMain"
sc config "SysMain" start=disabled
goto :advanceback
:advancem1on
sc config "SysMain" start=auto
sc start "SysMain"
goto :advanceback
:advancemenu2
cls
title Disk Defragment - Windows Maintenance
echo ==================================================================
echo 0. Disable
echo 1. Enable (Default)
echo +. Return to Upper Menu
echo ==================================================================
set /p sub=^> 
if [%sub%] equ [0] goto :advancem2off
if [%sub%] equ [1] goto :advancem2on
if [%sub%] equ [+] goto :advanceback
goto :advancemenu2
:advancem2off
schtasks /change /disable /tn "\Microsoft\Windows\Defrag\ScheduledDefrag"
goto :advanceback
:advancem2on
schtasks /change /enable /tn "\Microsoft\Windows\Defrag\ScheduledDefrag"
goto :advanceback
:advancemenu3
cls
title Diagnostic - Windows Maintenance
echo ==================================================================
echo 0. Disable
echo 1. Enable (Default)
echo +. Return to Upper Menu
echo ==================================================================
set /p sub=^> 
if [%sub%] equ [0] goto :advancem3off
if [%sub%] equ [1] goto :advancem3on
if [%sub%] equ [+] goto :advanceback
goto :advancemenu3
:advancem3off
schtasks /change /disable /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
schtasks /change /disable /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t "REG_DWORD" /d "0x00000000" /f
sc stop "DiagTrack"
sc config "DiagTrack" start=disabled
sc stop "DPS"
sc config "DPS" start=disabled
goto :advanceback
:advancem3on
schtasks /change /enable /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
schtasks /change /enable /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /f
sc config "DiagTrack" start=auto
sc start "DiagTrack"
sc config "DPS" start=auto
sc start "DPS"
goto :advanceback
:advancemenu4
cls
title Auto Maintenance - Windows Maintenance
echo ==================================================================
echo 0. Disable
echo 1. Enable (Default)
echo +. Return to Upper Menu
echo ==================================================================
set /p sub=^> 
if [%sub%] equ [0] goto :advancem4off
if [%sub%] equ [1] goto :advancem4on
if [%sub%] equ [+] goto :advanceback
goto :advancemenu4
:advancem4off
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /t "REG_DWORD" /d "0x00000001" /f
goto :advanceback
:advancem4on
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /f
goto :advanceback
:advanceback
set sec=
set sub=
goto :advancemain
:manageback
if exist "%~1" call "%~1"
goto :advancemain
