@echo off
set backup=%~dp0microcode_backup.zip
:main
title Microsoft Windows Tweaks
echo ==================================================================
echo 1. Manage Power plan
echo 2. Manage Diagnostic
echo 3. Manage Maintenance
echo 4. Manage CPU microcode
echo ==================================================================
set /p main=^> 
if [%main%] equ [1] goto :powerp
if [%main%] equ [2] goto :wndiag
if [%main%] equ [3] goto :wnmain
if [%main%] equ [4] goto :cpumic
goto :back
:powerp
echo.
title Manage Power Plan
echo ==================================================================
echo 1. Disable hibernation
echo 2. Restore hibernation
echo 3. Disable disk idle
echo 4. Restore disk idle
echo 0. Back to main menu
echo ==================================================================
set /p pow=^> 
if [%pow%] equ [1] goto :pwhoff
if [%pow%] equ [2] goto :powhon
if [%pow%] equ [3] goto :pwdoff
if [%pow%] equ [4] goto :powdon
if [%pow%] equ [0] goto :back
goto :powerp
:pwhoff
echo.
powercfg /hibernate off
goto :clear
:powhon
echo.
powercfg /hibernate on
goto :clear
:pwdoff
echo.
powercfg /change disk-timeout-ac 0
powercfg /change disk-timeout-dc 0
goto :clear
:powdon
echo.
powercfg /change disk-timeout-ac 20
powercfg /change disk-timeout-dc 20
goto :clear
:wndiag
echo.
title Manage Windows Diagnostic
echo ==================================================================
echo 1. Disable diagnostic
echo 2. Restore diagnostic
echo 0. Back to main menu
echo ==================================================================
set /p wda=^> 
if [%wda%] equ [1] goto :diaoff
if [%wda%] equ [2] goto :diagon
if [%wda%] equ [0] goto :back
goto :wndiag
:diaoff
echo.
schtasks /change /disable /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
schtasks /change /disable /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t "REG_DWORD" /d "0x00000000" /f
sc stop "DiagTrack"
sc config "DiagTrack" start=disabled
sc stop "DPS"
sc config "DPS" start=disabled
goto :clear
:diagon
echo.
schtasks /change /enable /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
schtasks /change /enable /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /f
sc config "DiagTrack" start=auto
sc start "DiagTrack"
sc config "DPS" start=auto
sc start "DPS"
goto :clear
:wnmain
echo.
title Manage Windows Maintenance
echo ==================================================================
echo 1. Disable auto maintenance
echo 2. Restore auto maintenance
echo 3. Disable disk defragment
echo 4. Restore disk defragment
echo 5. Disable super prefetch
echo 6. Restore super prefetch
echo 0. Back to main menu
echo ==================================================================
set /p man=^> 
if [%man%] equ [1] goto :manoff
if [%man%] equ [2] goto :mainon
if [%man%] equ [3] goto :frgoff
if [%man%] equ [4] goto :fragon
if [%man%] equ [5] goto :fetoff
if [%man%] equ [6] goto :fechon
if [%man%] equ [0] goto :back
goto :wnmain
:manoff
echo.
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /t "REG_DWORD" /d "0x00000001" /f
goto :clear
:mainon
echo.
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /f
goto :clear
:frgoff
echo.
schtasks /change /disable /tn "\Microsoft\Windows\Defrag\ScheduledDefrag"
goto :clear
:fragon
echo.
schtasks /change /enable /tn "\Microsoft\Windows\Defrag\ScheduledDefrag"
goto :clear
:fetoff
echo.
sc stop "SysMain"
sc config "SysMain" start=disabled
goto :clear
:fechon
echo.
sc config "SysMain" start=auto
sc start "SysMain"
goto :clear
:cpumic
echo.
title Manage CPU Microcode
echo ==================================================================
echo 1. Remove CPU microcode
echo 2. Restore CPU microcode
echo 0. Back to main menu
echo ==================================================================
set /p cpu=^> 
if [%cpu%] equ [1] goto :cpurem
if [%cpu%] equ [2] goto :cpubak
if [%cpu%] equ [0] goto :back
goto cpumic
:cpurem
pushd %SystemRoot%\System32
powershell -Command "Compress-Archive -Force -Path 'mcupdate_AuthenticAMD.dll','mcupdate_GenuineIntel.dll' -DestinationPath '%backup%'"
cmd /c takeown /f mcupdate_AuthenticAMD.dll && icacls mcupdate_AuthenticAMD.dll /grant Administrators:F
cmd /c takeown /f mcupdate_GenuineIntel.dll && icacls mcupdate_GenuineIntel.dll /grant Administrators:F
del "mcupdate_AuthenticAMD.dll" "mcupdate_GenuineIntel.dll" /f /q
goto :clear
:cpubak
if not exist "%backup%" goto :back
powershell -Command "Expand-Archive -Force -Path '%backup%' -DestinationPath '%SystemRoot%\System32'"
goto :clear
:clear
echo.
pause
:back
set main=
set pow=
set wda=
set man=
set cpu=
cls
goto :main

