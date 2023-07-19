@echo off
set backup=%~dp0microcode_backup.zip
:main
title Windows Management Tweaks
echo ==================================================================
echo 1. Power Plan
echo 2. Diagnostic
echo 3. Maintenance
echo 4. Defender Anti-virus
echo 5. System Update
echo 6. Accessibility
echo 7. CPU Microcode
echo ==================================================================
set /p main=^> 
if [%main%] equ [1] goto :powerp
if [%main%] equ [2] goto :wndiag
if [%main%] equ [3] goto :wnmain
if [%main%] equ [4] goto :antivr
if [%main%] equ [5] goto :update
if [%main%] equ [6] goto :accbly
if [%main%] equ [7] goto :cpumic
goto :back
:powerp
cls
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
cls
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
cls
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
:antivr
cls
title Manage Microsoft Defender Anti-virus
echo ==================================================================
echo 1. Disable context menu
echo 2. Restore context menu
echo 3. Disable system tray icon
echo 4. Restore system tray icon
echo 5. Disable scheduled scan
echo 6. Restore scheduled scan
echo 7. Disable real-time protection
echo 8. Restore real-time protection
echo 0. Back to main menu
echo ==================================================================
set /p avr=^> 
if [%avr%] equ [1] goto :ctxoff
if [%avr%] equ [2] goto :ctxmon
if [%avr%] equ [3] goto :traoff
if [%avr%] equ [4] goto :trayon
if [%avr%] equ [5] goto :scnoff
if [%avr%] equ [6] goto :scanon
if [%avr%] equ [7] goto :reloff
if [%avr%] equ [8] goto :realon
if [%avr%] equ [0] goto :back
goto :antivr
:ctxoff
echo.
reg delete "HKCR\*\shellex\ContextMenuHandlers\EPP" /ve /f
reg delete "HKCR\Drive\shellex\ContextMenuHandlers\EPP" /ve /f
reg delete "HKCR\Directory\shellex\ContextMenuHandlers\EPP" /ve /f
reg delete "HKCR\CLSID\{09A47860-11B0-4DA5-AFA5-26D86198A780}\InprocServer32" /ve /f
goto :clear
:ctxmon
echo.
reg add "HKCR\*\shellex\ContextMenuHandlers\EPP" /ve /t "REG_SZ" /d "{09A47860-11B0-4DA5-AFA5-26D86198A780}" /f
reg add "HKCR\Drive\shellex\ContextMenuHandlers\EPP" /ve /t "REG_SZ" /d "{09A47860-11B0-4DA5-AFA5-26D86198A780}" /f
reg add "HKCR\Directory\shellex\ContextMenuHandlers\EPP" /ve /t "REG_SZ" /d "{09A47860-11B0-4DA5-AFA5-26D86198A780}" /f
reg add "HKCR\CLSID\{09A47860-11B0-4DA5-AFA5-26D86198A780}\InprocServer32" /ve /t "REG_SZ" /d "%ProgramFiles%\Windows Defender\shellext.dll" /f
goto :clear
:traoff
echo.
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray" /v "HideSystray" /t "REG_DWORD" /D "0x00000001" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "SecurityHealth" /t "REG_BINARY" /D "07000000CD54F699D161D900" /f
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth" /f
goto :clear
:trayon
echo.
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray" /v "HideSystray" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "SecurityHealth" /t "REG_BINARY" /d "060000000000000000000000" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth" /t "REG_EXPAND_SZ" /d "%%windir%%\system32\SecurityHealthSystray.exe" /f
goto :clear
:scnoff
echo.
schtasks /change /disable /tn "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan"
goto :clear
:scanon
echo.
schtasks /change /enable /tn "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan"
goto :clear
:reloff
echo.
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t "REG_DWORD" /D "0x00000001" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t "REG_DWORD" /D "0x00000001" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /t "REG_DWORD" /D "0x00000001" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableScanOnRealtimeEnable" /t "REG_DWORD" /D "0x00000001" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WinDefend" /v "Start" /t "REG_DWORD" /D "0x00000004" /f
goto :clear
:realon
echo.
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /f
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WinDefend" /v "Start" /t "REG_DWORD" /d "0x00000002" /f
goto :clear
:update
cls
title Manage Windows Update
echo ==================================================================
echo 1. Disable auto update
echo 2. Restore auto update
echo 3. Disable drivers auto update
echo 4. Restore drivers auto update
echo 5. Disable wuauserv service
echo 6. Restore wuauserv service
echo 0. Back to main menu
echo ==================================================================
set /p upd=^> 
if [%upd%] equ [1] goto :autoff
if [%upd%] equ [2] goto :autoon
if [%upd%] equ [3] goto :drvoff
if [%upd%] equ [4] goto :drivon
if [%upd%] equ [3] goto :wusoff
if [%upd%] equ [4] goto :wusvon
if [%upd%] equ [0] goto :back
goto :update
:autoff
echo.
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t "REG_DWORD" /d "0x00000001" /f
goto :clear
:autoon
echo.
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /f
goto :clear
:drvoff
echo.
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /t "REG_DWORD" /d "0x00000001" /f
goto :clear
:drivon
echo.
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /f
goto :clear
:wusoff
echo.
sc stop "wuauserv"
sc config "wuauserv" start=disabled
goto :clear
:wusvon
echo.
sc config "wuauserv" start=demand
sc start "wuauserv"
goto :clear
:accbly
cls
title Manage Windows Accebility
echo ==================================================================
echo 1. Context Menu as Windows 10
echo 2. Context Menu as Windows 11
echo 0. Back to main menu
echo ==================================================================
set /p acc=^> 
if [%acc%] equ [1] goto :ctxoff
if [%acc%] equ [2] goto :ctxmon
if [%acc%] equ [0] goto :back
goto :accbly
:ctxoff
echo.
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /ve /d "" /f
goto :clear
:ctxmon
echo.
reg delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f
goto :clear
:cpumic
cls
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
goto :cpumic
:cpurem
echo.
pushd %SystemRoot%\System32
powershell -Command "Compress-Archive -Force -Path 'mcupdate_AuthenticAMD.dll','mcupdate_GenuineIntel.dll' -DestinationPath '%backup%'"
takeown /f mcupdate_AuthenticAMD.dll && icacls mcupdate_AuthenticAMD.dll /grant Administrators:F
takeown /f mcupdate_GenuineIntel.dll && icacls mcupdate_GenuineIntel.dll /grant Administrators:F
del "mcupdate_AuthenticAMD.dll" "mcupdate_GenuineIntel.dll" /f /q
goto :clear
:cpubak
if not exist "%backup%" goto :back
echo.
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
set upd=
set cpu=
cls
goto :main

