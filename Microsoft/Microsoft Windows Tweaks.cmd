@echo off
set backup=%~dp0microcode_backup.zip
:main
title Windows Management Tweaks
echo ==================================================================
echo 1. Power Plan
echo 2. System Update
echo 3. Defender Anti-virus
echo 4. Diagnostic ^& Maintenance
echo 5. Accessibility
echo ==================================================================
set /p main=^> 
echo.
if [%main%] equ [1] goto :powerp
if [%main%] equ [2] goto :update
if [%main%] equ [3] goto :antivr
if [%main%] equ [4] goto :diaman
if [%main%] equ [5] goto :acsbly
goto :back
:powerp
cls
title Manage Power Plan
echo ==================================================================
echo 1. Disable hibernation
echo 2. Restore hbernation
echo 3. Disable disk idle timeout
echo 4. Restore disk idle timeout
echo 5. Better heterogeneous thread policy
echo 6. Restore heterogeneous thread policy
echo 0. Back to main menu
echo ==================================================================
set /p act=^> 
echo.
if [%act%] equ [1] goto :pwhoff
if [%act%] equ [2] goto :powhon
if [%act%] equ [3] goto :pwdoff
if [%act%] equ [4] goto :powdon
if [%act%] equ [5] goto :hperon
if [%act%] equ [6] goto :hproff
if [%act%] equ [0] goto :back
goto :powerp
:pwhoff
powercfg /hibernate off
goto :done
:powhon
powercfg /hibernate on
goto :done
:pwdoff
powercfg /change disk-timeout-ac 0
powercfg /change disk-timeout-dc 0
goto :done
:powdon
powercfg /change disk-timeout-ac 20
powercfg /change disk-timeout-dc 20
goto :done
:hperon
powercfg /setacvalueindex scheme_current sub_processor SCHEDPOLICY 2
powercfg /setacvalueindex scheme_current sub_processor SHORTSCHEDPOLICY 2
goto :done
:hproff
powercfg /setacvalueindex scheme_current sub_processor SCHEDPOLICY 5
powercfg /setacvalueindex scheme_current sub_processor SHORTSCHEDPOLICY 5
goto :done
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
set /p act=^> 
echo.
if [%act%] equ [1] goto :autoff
if [%act%] equ [2] goto :autoon
if [%act%] equ [3] goto :drvoff
if [%act%] equ [4] goto :drivon
if [%act%] equ [5] goto :wusoff
if [%act%] equ [6] goto :wusvon
if [%act%] equ [0] goto :back
goto :update
:autoff
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t "REG_DWORD" /d "0x00000001" /f
goto :done
:autoon
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /f
goto :done
:drvoff
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /t "REG_DWORD" /d "0x00000001" /f
goto :done
:drivon
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /f
goto :done
:wusoff
sc stop "wuauserv"
sc config "wuauserv" start=disabled
goto :done
:wusvon
sc config "wuauserv" start=demand
sc start "wuauserv"
goto :done
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
set /p act=^> 
echo.
if [%act%] equ [1] goto :ctxoff
if [%act%] equ [2] goto :ctxmon
if [%act%] equ [3] goto :traoff
if [%act%] equ [4] goto :trayon
if [%act%] equ [5] goto :scnoff
if [%act%] equ [6] goto :scanon
if [%act%] equ [7] goto :reloff
if [%act%] equ [8] goto :realon
if [%act%] equ [0] goto :back
goto :antivr
:ctxoff
reg delete "HKCR\*\shellex\ContextMenuHandlers\EPP" /ve /f
reg delete "HKCR\Drive\shellex\ContextMenuHandlers\EPP" /ve /f
reg delete "HKCR\Directory\shellex\ContextMenuHandlers\EPP" /ve /f
reg delete "HKCR\CLSID\{09A47860-11B0-4DA5-AFA5-26D86198A780}\InprocServer32" /ve /f
goto :done
:ctxmon
reg add "HKCR\*\shellex\ContextMenuHandlers\EPP" /ve /t "REG_SZ" /d "{09A47860-11B0-4DA5-AFA5-26D86198A780}" /f
reg add "HKCR\Drive\shellex\ContextMenuHandlers\EPP" /ve /t "REG_SZ" /d "{09A47860-11B0-4DA5-AFA5-26D86198A780}" /f
reg add "HKCR\Directory\shellex\ContextMenuHandlers\EPP" /ve /t "REG_SZ" /d "{09A47860-11B0-4DA5-AFA5-26D86198A780}" /f
reg add "HKCR\CLSID\{09A47860-11B0-4DA5-AFA5-26D86198A780}\InprocServer32" /ve /t "REG_SZ" /d "%ProgramFiles%\Windows Defender\shellext.dll" /f
goto :done
:traoff
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray" /v "HideSystray" /t "REG_DWORD" /D "0x00000001" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "SecurityHealth" /t "REG_BINARY" /D "07000000CD54F699D161D900" /f
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth" /f
goto :done
:trayon
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray" /v "HideSystray" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "SecurityHealth" /t "REG_BINARY" /d "060000000000000000000000" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth" /t "REG_EXPAND_SZ" /d "%%windir%%\system32\SecurityHealthSystray.exe" /f
goto :done
:scnoff
schtasks /change /disable /tn "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan"
goto :done
:scanon
schtasks /change /enable /tn "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan"
goto :done
:reloff
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t "REG_DWORD" /D "0x00000001" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t "REG_DWORD" /D "0x00000001" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /t "REG_DWORD" /D "0x00000001" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableScanOnRealtimeEnable" /t "REG_DWORD" /D "0x00000001" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WinDefend" /v "Start" /t "REG_DWORD" /D "0x00000004" /f
goto :done
:realon
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /f
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WinDefend" /v "Start" /t "REG_DWORD" /d "0x00000002" /f
goto :done
:diaman
cls
title Manage Windows Maintenance
echo ==================================================================
echo 1. Disable diagnostic
echo 2. Restore diagnostic
echo 3. Disable auto maintenance
echo 4. Restore auto maintenance
echo 5. Disable disk defragment
echo 6. Restore disk defragment
echo 7. Disable super prefetch
echo 8. Restore super prefetch
echo 0. Back to main menu
echo ==================================================================
set /p act=^> 
echo.
if [%act%] equ [1] goto :diaoff
if [%act%] equ [2] goto :diagon
if [%act%] equ [3] goto :manoff
if [%act%] equ [4] goto :mainon
if [%act%] equ [5] goto :frgoff
if [%act%] equ [6] goto :fragon
if [%act%] equ [7] goto :fetoff
if [%act%] equ [8] goto :fechon
if [%act%] equ [0] goto :back
goto :diaman
:diaoff
schtasks /change /disable /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
schtasks /change /disable /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t "REG_DWORD" /d "0x00000000" /f
sc stop "DiagTrack"
sc config "DiagTrack" start=disabled
sc stop "DPS"
sc config "DPS" start=disabled
goto :done
:diagon
schtasks /change /enable /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
schtasks /change /enable /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /f
sc config "DiagTrack" start=auto
sc start "DiagTrack"
sc config "DPS" start=auto
sc start "DPS"
goto :done
:manoff
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /t "REG_DWORD" /d "0x00000001" /f
goto :done
:mainon
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /f
goto :done
:frgoff
schtasks /change /disable /tn "\Microsoft\Windows\Defrag\ScheduledDefrag"
goto :done
:fragon
schtasks /change /enable /tn "\Microsoft\Windows\Defrag\ScheduledDefrag"
goto :done
:fetoff
sc stop "SysMain"
sc config "SysMain" start=disabled
goto :done
:fechon
sc config "SysMain" start=auto
sc start "SysMain"
goto :done
:acsbly
cls
title Manage Windows Accebility
echo ==================================================================
echo 1. Context Menu as Windows 10
echo 2. Context Menu as Windows 11
echo 3. Disable CPU microcode
echo 4. Restore CPU microcode
echo 0. Back to main menu
echo ==================================================================
set /p act=^> 
echo.
if [%act%] equ [1] goto :ctxoff
if [%act%] equ [2] goto :ctxmon
if [%act%] equ [3] goto :cpurem
if [%act%] equ [4] goto :cpubak
if [%act%] equ [0] goto :back
goto :acsbly
:ctxoff
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /ve /d "" /f
goto :done
:ctxmon
reg delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f
goto :done
:cpurem
pushd %SystemRoot%\System32
powershell -Command "Compress-Archive -Force -Path 'mcupdate_AuthenticAMD.dll','mcupdate_GenuineIntel.dll' -DestinationPath '%backup%'"
takeown /f mcupdate_AuthenticAMD.dll && icacls mcupdate_AuthenticAMD.dll /grant Administrators:F
takeown /f mcupdate_GenuineIntel.dll && icacls mcupdate_GenuineIntel.dll /grant Administrators:F
del "mcupdate_AuthenticAMD.dll" "mcupdate_GenuineIntel.dll" /f /q
goto :done
:cpubak
if not exist "%backup%" goto :back
powershell -Command "Expand-Archive -Force -Path '%backup%' -DestinationPath '%SystemRoot%\System32'"
goto :done
:done
pause
:back
set main=
set act=
cls
goto :main
