@echo off
set main="%~1"
:winmain
cls
title Manage Windows Maintenance
echo ==================================================================
echo 1. Manage Super Prefetch
echo 2. Manage Disk Defragment
echo 3. Manage Diagnostic
echo 4. Manage Auto Maintenance
if exist %main% echo +. Return to Main Menu
echo ==================================================================
set /p mnact=^> 
if [%mnact%] equ [1] goto :mnmenu1
if [%mnact%] equ [2] goto :mnmenu2
if [%mnact%] equ [3] goto :mnmenu3
if [%mnact%] equ [4] goto :mnmenu4
if [%mnact%] equ [+] goto :mainmenu
goto :winmain
:mnmenu1
cls
title Super Prefetch - Windows Maintenance
echo ==================================================================
echo 0. Disable
echo 1. Enable (Default)
echo +. Return to Upper Menu
echo ==================================================================
set /p mnsub=^> 
if [%mnsub%] equ [0] goto :mnm1off
if [%mnsub%] equ [1] goto :mnm1on
if [%mnsub%] equ [+] goto :return
goto :mnmenu1
:mnm1off
sc stop "SysMain"
sc config "SysMain" start=disabled
goto :return
:mnm1on
sc config "SysMain" start=auto
sc start "SysMain"
goto :return
:mnmenu2
cls
title Disk Defragment - Windows Maintenance
echo ==================================================================
echo 0. Disable
echo 1. Enable (Default)
echo +. Return to Upper Menu
echo ==================================================================
set /p mnsub=^> 
if [%mnsub%] equ [0] goto :mnm2off
if [%mnsub%] equ [1] goto :mnm2on
if [%mnsub%] equ [+] goto :return
goto :mnmenu2
:mnm2off
schtasks /change /disable /tn "\Microsoft\Windows\Defrag\ScheduledDefrag"
goto :return
:mnm2on
schtasks /change /enable /tn "\Microsoft\Windows\Defrag\ScheduledDefrag"
goto :return
:mnmenu3
cls
title Diagnostic - Windows Maintenance
echo ==================================================================
echo 0. Disable
echo 1. Enable (Default)
echo +. Return to Upper Menu
echo ==================================================================
set /p mnsub=^> 
if [%mnsub%] equ [0] goto :mnm3off
if [%mnsub%] equ [1] goto :mnm3on
if [%mnsub%] equ [+] goto :return
goto :mnmenu3
:mnm3off
schtasks /change /disable /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
schtasks /change /disable /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t "REG_DWORD" /d "0x00000000" /f
sc stop "DiagTrack"
sc config "DiagTrack" start=disabled
sc stop "DPS"
sc config "DPS" start=disabled
goto :return
:mnm3on
schtasks /change /enable /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
schtasks /change /enable /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /f
sc config "DiagTrack" start=auto
sc start "DiagTrack"
sc config "DPS" start=auto
sc start "DPS"
goto :return
:mnmenu4
cls
title Auto Maintenance - Windows Maintenance
echo ==================================================================
echo 0. Disable
echo 1. Enable (Default)
echo +. Return to Upper Menu
echo ==================================================================
set /p mnsub=^> 
if [%mnsub%] equ [0] goto :mnm4off
if [%mnsub%] equ [1] goto :mnm4on
if [%mnsub%] equ [+] goto :return
goto :mnmenu4
:mnm4off
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /t "REG_DWORD" /d "0x00000001" /f
goto :return
:mnm4on
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /f
goto :return
:mainmenu
if exist %main% call %main%
goto :winmain
:return
set mnact=
set mnsub=
timeout /t 5
goto :winmain
