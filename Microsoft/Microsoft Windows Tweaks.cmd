@echo off
net session >nul 2>&1 && goto :admin
mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c ""%~s0"" %*","","runas",1)(window.close)
exit
:admin
set ppmenu="%~dp0Windows Power Plan.cmd"
set wumenu="%~dp0Windows Update.cmd"
set egmenu="%~dp0Microsoft Edge Tweaks.cmd"
set avmenu="%~dp0Windows Advanced Tweaks.cmd"
:mainmenu
cls
title Windows Management Tweaks
echo ==================================================================
if exist %ppmenu% echo 1. Windows Power Plan
if exist %wumenu% echo 2. Windows Update
if exist %egmenu% echo 3. Microsoft Edge
echo 4. Defender Anti-virus
echo 5. Diagnostic ^& Maintenance
if exist %avmenu% echo 6. Advanced Tweaks
echo ==================================================================
set /p main=^> 
echo.
if [%main%] equ [1] call :external %ppmenu%
if [%main%] equ [2] call :external %wumenu%
if [%main%] equ [3] call :external %egmenu%
if [%main%] equ [4] goto :antivr
if [%main%] equ [5] goto :diaman
if [%main%] equ [6] call :external %avmenu%
goto :back
:external
if exist %1 call %1 "%~s0"
goto :mainmenu
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
echo 0. Return Upper Menu
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
goto :return
:ctxmon
reg add "HKCR\*\shellex\ContextMenuHandlers\EPP" /ve /t "REG_SZ" /d "{09A47860-11B0-4DA5-AFA5-26D86198A780}" /f
reg add "HKCR\Drive\shellex\ContextMenuHandlers\EPP" /ve /t "REG_SZ" /d "{09A47860-11B0-4DA5-AFA5-26D86198A780}" /f
reg add "HKCR\Directory\shellex\ContextMenuHandlers\EPP" /ve /t "REG_SZ" /d "{09A47860-11B0-4DA5-AFA5-26D86198A780}" /f
reg add "HKCR\CLSID\{09A47860-11B0-4DA5-AFA5-26D86198A780}\InprocServer32" /ve /t "REG_SZ" /d "%ProgramFiles%\Windows Defender\shellext.dll" /f
goto :return
:traoff
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray" /v "HideSystray" /t "REG_DWORD" /D "0x00000001" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "SecurityHealth" /t "REG_BINARY" /D "07000000CD54F699D161D900" /f
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth" /f
goto :return
:trayon
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray" /v "HideSystray" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "SecurityHealth" /t "REG_BINARY" /d "060000000000000000000000" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth" /t "REG_EXPAND_SZ" /d "%%windir%%\system32\SecurityHealthSystray.exe" /f
goto :return
:scnoff
schtasks /change /disable /tn "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan"
goto :return
:scanon
schtasks /change /enable /tn "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan"
goto :return
:reloff
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t "REG_DWORD" /D "0x00000001" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t "REG_DWORD" /D "0x00000001" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /t "REG_DWORD" /D "0x00000001" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableScanOnRealtimeEnable" /t "REG_DWORD" /D "0x00000001" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WinDefend" /v "Start" /t "REG_DWORD" /D "0x00000004" /f
goto :return
:realon
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /f
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WinDefend" /v "Start" /t "REG_DWORD" /d "0x00000002" /f
goto :return
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
echo 0. Return Upper Menu
echo ==================================================================
set /p act=^> 
echo.
if [%act%] equ [1] goto :diaoff
if [%act%] equ [2] goto :diagon
if [%act%] equ [3] goto :manoff
if [%act%] equ [4] goto :mainmenuon
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
goto :return
:diagon
schtasks /change /enable /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
schtasks /change /enable /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /f
sc config "DiagTrack" start=auto
sc start "DiagTrack"
sc config "DPS" start=auto
sc start "DPS"
goto :return
:manoff
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /t "REG_DWORD" /d "0x00000001" /f
goto :return
:mainmenuon
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /f
goto :return
:frgoff
schtasks /change /disable /tn "\Microsoft\Windows\Defrag\ScheduledDefrag"
goto :return
:fragon
schtasks /change /enable /tn "\Microsoft\Windows\Defrag\ScheduledDefrag"
goto :return
:fetoff
sc stop "SysMain"
sc config "SysMain" start=disabled
goto :return
:fechon
sc config "SysMain" start=auto
sc start "SysMain"
goto :return
:return
pause
:back
set main=
set act=
cls
goto :mainmenu
