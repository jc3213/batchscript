@echo off
net session >nul 2>nul && goto :runasadmin
mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c ""%~s0"" %*","","runas",1)(window.close)
exit
:runasadmin
set amdcpu=%systemroot%\System32\mcupdate_GenuineIntel.dll
set intlcpu=%systemroot%\System32\mcupdate_AuthenticAMD.dll
set cpuback="%~dp0microcode_backup.zip"
:managemain
cls
title Windows Management Tweaks
echo ==================================================================
echo 1. Windows Power Plan
echo 2. Windows Update
echo 3. Microsoft Edge
echo 4. Microsoft Defender
echo 5. Windows Maintenance
echo 6. Windows Accessibility
echo ==================================================================
set /p mainmenu=^> 
if [%mainmenu%] equ [1] goto :powermain
if [%mainmenu%] equ [2] goto :updatemain
if [%mainmenu%] equ [3] goto :msedgemain
if [%mainmenu%] equ [4] goto :virusmain
if [%mainmenu%] equ [5] goto :advancemain
if [%mainmenu%] equ [6] goto :miscmain
goto :managemain
:manageback
set mainmenu=
goto :managemain
:powermain
cls
title Manage Windows Power Plan
echo ==================================================================
echo 1. Manage Hibernation
echo 2. Manage Disk Idle Timeout
echo 3. Manage Processor Maximum P-state
echo 4. Manage Processor Minimum P-state
echo 5. Manage Heterogeneous Thread Policy
echo +. Return to Main Menu
echo ==================================================================
set /p pwrmenu=^> 
if [%pwrmenu%] equ [1] goto :powermenu1
if [%pwrmenu%] equ [2] goto :powermenu2
if [%pwrmenu%] equ [3] goto :powermenu3
if [%pwrmenu%] equ [4] goto :powermenu4
if [%pwrmenu%] equ [5] goto :powermenu5
if [%pwrmenu%] equ [+] goto :manageback
goto :powermain
:powermenu1
cls
title Hibernation - Power Plan
echo ==================================================================
echo 0. Disable
echo 1. Enable
echo +. Return to Upper Menu
echo ==================================================================
set /p pwrsub=^> 
if [%pwrsub%] equ [0] call :powerm1app off
if [%pwrsub%] equ [1] call :powerm1app on
if [%pwrsub%] equ [+] goto :powerback
goto :powermenu1
:powerm1app
powercfg /hibernate %1
goto :powerback
:powermenu2
cls
title Disk Idle Timeout - Power Plan
echo ==================================================================
echo 0. Never
echo 1. Default (20 minutes)
echo +. Return to Upper Menu
echo ==================================================================
set /p pwrsub=^> 
if [%pwrsub%] equ [0] call :powerm2app 0
if [%pwrsub%] equ [1] call :powerm2app 20
if [%pwrsub%] equ [+] goto :powerback
goto :powermenu2
:powerm2app
powercfg /change disk-timeout-ac %1
powercfg /change disk-timeout-dc %1
goto :powerback
:powermenu3
cls
title Processor Maximum P-state - Power Plan
echo ==================================================================
echo Minimum: 50
echo Maximum: 100 (Default)
echo ==================================================================
set /p pwrsub=^> 
echo %pwrsub%| findstr /r /c:"^[5-9][0-9]$" /c:"^100$" >nul
if %errorlevel% equ 1 set pwrsub=100
call :powerm34app MAX %pwrsub%
:powermenu4
cls
title Processor Minimum P-state - Power Plan
echo ==================================================================
echo Minimum: 0 (Default)
echo Maximum: 100
echo ==================================================================
set /p pwrsub=^> 
echo %pwrsub%| findstr /r /c:"^[0-9]$" /c:"^[1-9][0-9]$" /c:"^100$" >nul
if %errorlevel% equ 1 set pwrsub=0
call :powerm34app MIN %pwrsub%
:powermenu5
cls
title Heterogeneous Thread Policy - Power Plan
echo ==================================================================
echo 0. Default (Automatic)
echo 1. Prefer performant processors
echo +. Return to Upper Menu
echo ==================================================================
set /p pwrsub=^> 
if [%pwrsub%] equ [0] call :powerm5app 5
if [%pwrsub%] equ [1] call :powerm5app 2
if [%pwrsub%] equ [+] goto :powerback
goto :powermenu5
:powerm5app
powercfg /setacvalueindex scheme_current sub_processor SCHEDPOLICY %1
powercfg /setacvalueindex scheme_current sub_processor SHORTSCHEDPOLICY %1
powercfg /setactive scheme_current
goto :powerback
:powerm34app
powercfg /setacvalueindex scheme_current sub_processor PROCTHROTTLE%1 %2
powercfg /setactive scheme_current
goto :powerback
:updatemain
cls
title Manage Windows Update
echo ==================================================================
echo 1. Manage Auto Update
echo 2. Manage Driver Auto Update
echo 3. Manage Windows Update Service (wuauserv)
echo 4. Manage Malicious Software Removal Tool
echo +. Return to Main Menu
echo ==================================================================
set /p submenu=^> 
if [%submenu%] equ [1] goto :updatemenu1
if [%submenu%] equ [2] goto :updatemenu2
if [%submenu%] equ [3] goto :updatemenu3
if [%submenu%] equ [4] goto :updatemenu4
if [%submenu%] equ [+] goto :manageback
goto :updatemain
:updatemain
cls
title Manage Windows Update
echo ==================================================================
echo 1. Manage Auto Update
echo 2. Manage Driver Auto Update
echo 3. Manage Windows Update Service (wuauserv)
echo 4. Manage Malicious Software Removal Tool
echo +. Return to Main Menu
echo ==================================================================
set /p updmenu=^> 
if [%updmenu%] equ [1] goto :updatemenu1
if [%updmenu%] equ [2] goto :updatemenu2
if [%updmenu%] equ [3] goto :updatemenu3
if [%updmenu%] equ [4] goto :updatemenu4
if [%updmenu%] equ [+] goto :manageback
goto :updatemain
:updatemenu1
cls
title Auto Update - Windows Update
echo ==================================================================
echo 0. Disable
echo 1. Enable (Default)
echo +. Return to Upper Menu
echo ==================================================================
set /p updsub=^> 
if [%updsub%] equ [0] goto :updatem1off
if [%updsub%] equ [1] goto :updatem1on
if [%updsub%] equ [+] goto :updateback
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
set /p updsub=^> 
if [%updsub%] equ [0] goto :updatem2off
if [%updsub%] equ [1] goto :updatem2on
if [%updsub%] equ [+] goto :updateback
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
set /p updsub=^> 
if [%updsub%] equ [0] goto :updatem3off
if [%updsub%] equ [1] goto :updatem3on
if [%updsub%] equ [+] goto :updateback
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
set /p updsub=^> 
if [%updsub%] equ [0] goto :updatem4off
if [%updsub%] equ [1] goto :updatem4on
if [%updsub%] equ [+] goto :updateback
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
set updmenu=
set updsub=
goto :updatemain
:msedgemain
cls
title Manage Microsoft Edge
echo ==================================================================
echo 1. Bing Discovery Button
echo 2. Desktop Search Bar
echo 3. Alt + Tab Behavior
echo 4. User Profile Directory
echo 5. Browser Caches Directory
echo +. Return to Main Menu
echo ==================================================================
set /p edgmenu=^> 
if [%edgmenu%] equ [1] goto :msedgemenu1
if [%edgmenu%] equ [2] goto :msedgemenu2
if [%edgmenu%] equ [3] goto :msedgemenu3
if [%edgmenu%] equ [4] goto :msedgemenu4
if [%edgmenu%] equ [5] goto :msedgemenu5
if [%edgmenu%] equ [+] goto :manageback
goto :msedgemain
:msedgemenu1
cls
title Manage Bing Discovery Button - Microsoft Edge
echo ==================================================================
echo 0. Hide
echo 1. Show (Default)
echo +. Return to Upper Menu
echo ==================================================================
set /p edgsub=^> 
if [%edgsub%] equ [0] goto :msedgem1off
if [%edgsub%] equ [1] goto :msedgem1on
if [%edgsub%] equ [+] goto :msedgeback
goto :msedgemenu1
:msedgem1off
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "HubsSidebarEnabled"  /t "REG_DWORD" /d "0x00000000" /f
goto :msedgeback
:msedgem1on
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "HubsSidebarEnabled" /f
goto :msedgeback
:msedgemenu2
cls
title Manage Desktop Search Bar - Microsoft Edge
echo ==================================================================
echo 0. Hide
echo 1. Show (Default)
echo +. Return to Upper Menu
echo ==================================================================
set /p edgsub=^> 
if [%edgsub%] equ [0] goto :msedgem2off
if [%edgsub%] equ [1] goto :msedgem2on
if [%edgsub%] equ [+] goto :msedgeback
goto :msedgemenu2
:msedgem2off
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "WebWidgetAllowed"  /t "REG_DWORD" /d "0x00000000" /f
goto :msedgeback
:msedgem2on
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "WebWidgetAllowed" /f
goto :msedgeback
:msedgemenu3
cls
title Manage Alt + Tab Behavior - Microsoft Edge
echo ==================================================================
echo 0. Default
echo 1. Switch only via windows
echo +. Return to Main Menu
echo ==================================================================
set /p edgsub=^> 
if [%edgsub%] equ [0] goto :msedgem3off
if [%edgsub%] equ [1] goto :msedgem3on
if [%edgsub%] equ [+] goto :msedgeback
goto :msedgemenu3
:msedgem3off
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "MultiTaskingegmenu3Filter" /f
goto :msedgeback
:msedgem3on
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "MultiTaskingegmenu3Filter" /t "REG_DWORD" /d "0x00000003" /f
goto :msedgeback
:msedgemenu4
cls
title Manage User Profile Directory - Microsoft Edge
echo ==================================================================
echo 0. Default Directory
echo 1. Move to Documents
echo 2. Move to User Directory
echo +. Return to Main Menu
echo ==================================================================
set /p edgsub=^> 
if [%edgsub%] equ [0] goto :msedgem4off
if [%edgsub%] equ [1] goto :msedgem4on
if [%edgsub%] equ [2] goto :msedgem4sel
if [%edgsub%] equ [+] goto :msedgeback
goto :msedgemenu4
:msedgem4off
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "UserDataDir" /f
goto :msedgeback
:msedgem4on
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "UserDataDir"  /t "REG_SZ" /d "%userprofile%\Documents\EdgeUserData" /f
goto :msedgeback
:msedgem4sel
call :foldersel
if not defined sub goto :msedgemenu4
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "UserDataDir"  /t "REG_SZ" /d "%edgsub%" /f
goto :msedgeback
:msedgemenu5
cls
title Manage Browser Caches Directory - Microsoft Edge
echo ==================================================================
echo 0. Default Directory
echo 1. Move to RAMDISK
echo 2. Move to User Directory
echo +. Return to Main Menu
echo ==================================================================
set /p edgsub=^> 
if [%edgsub%] equ [0] goto :msedgem5off
if [%edgsub%] equ [1] goto :msedgem5on
if [%edgsub%] equ [2] goto :msedgem5sel
if [%edgsub%] equ [+] goto :msedgeback
goto :msedgemenu5
:msedgem5off
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "DiskCacheDir" /f
goto :msedgeback
:msedgem5on
for /f %%a in ('wmic logicaldisk where "VolumeName='RAMDISK'" get Caption ^| find ":"') do (set ramdisk=%%a\Temp)
if not exist "%ramdisk%" goto :msedgemenu5
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "DiskCacheDir" /t "REG_SZ" /d "%ramdisk%" /f
:msedgem5sel
call :foldersel
if not defined sub goto :msedgemenu5
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "DiskCacheDir" /t "REG_SZ" /d "%edgsub%" /f
goto :msedgeback
:foldersel
for /f "delims=" %%a in ('powershell -Command "Add-Type -AssemblyName System.windows.forms; $dialog = New-Object System.Windows.Forms.FolderBrowserDialog;$dialog.ShowDialog() | Out-Null;$dialog.SelectedPath"') do (set function=%%a)
exit /b
:msedgeback
set edgmenu=
set edgsub=
goto :msedgemain
:virusmain
cls
title Manage Windows Defender
echo ==================================================================
echo 1. Manage Context Menu
echo 2. Manage System Tray Icon
echo 3. Manage Scheduled Scan
echo 4. Manage Real-time Protection
echo +. Return to Main Menu
echo ==================================================================
set /p avrmenu=^> 
if [%avrmenu%] equ [1] goto :virusmenu1
if [%avrmenu%] equ [2] goto :virusmenu2
if [%avrmenu%] equ [3] goto :virusmenu3
if [%avrmenu%] equ [4] goto :virusmenu4
if [%avrmenu%] equ [+] goto :manageback
goto :virusmain
:virusmenu1
cls
title Context Menu - Windows Defender
echo ==================================================================
echo 0. Disable
echo 1. Enable (Default)
echo +. Return to Upper Menu
echo ==================================================================
set /p avrsub=^> 
if [%avrsub%] equ [0] goto :virusm1off
if [%avrsub%] equ [1] goto :virusm1on
if [%avrsub%] equ [+] goto :virusback
goto :virusmenu1
:virusm1off
reg delete "HKCR\*\shellex\ContextMenuHandlers\EPP" /ve /f
reg delete "HKCR\Drive\shellex\ContextMenuHandlers\EPP" /ve /f
reg delete "HKCR\Directory\shellex\ContextMenuHandlers\EPP" /ve /f
reg delete "HKCR\CLSID\{09A47860-11B0-4DA5-AFA5-26D86198A780}\InprocServer32" /ve /f
goto :virusback
:virusm1on
reg add "HKCR\*\shellex\ContextMenuHandlers\EPP" /ve /t "REG_SZ" /d "{09A47860-11B0-4DA5-AFA5-26D86198A780}" /f
reg add "HKCR\Drive\shellex\ContextMenuHandlers\EPP" /ve /t "REG_SZ" /d "{09A47860-11B0-4DA5-AFA5-26D86198A780}" /f
reg add "HKCR\Directory\shellex\ContextMenuHandlers\EPP" /ve /t "REG_SZ" /d "{09A47860-11B0-4DA5-AFA5-26D86198A780}" /f
reg add "HKCR\CLSID\{09A47860-11B0-4DA5-AFA5-26D86198A780}\InprocServer32" /ve /t "REG_SZ" /d "%programfiles%\Windows Defender\shellext.dll" /f
goto :virusback
:virusmenu2
cls
title System Tray Icon - Windows Defender
echo ==================================================================
echo 0. Disable
echo 1. Enable (Default)
echo +. Return to Upper Menu
echo ==================================================================
set /p avrsub=^> 
if [%avrsub%] equ [0] goto :virusm2off
if [%avrsub%] equ [1] goto :virusm2on
if [%avrsub%] equ [+] goto :virusback
goto :virusmenu2
:virusm2off
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray" /v "HideSystray" /t "REG_DWORD" /D "0x00000001" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "SecurityHealth" /t "REG_BINARY" /D "07000000CD54F699D161D900" /f
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth" /f
goto :virusback
:virusm2on
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray" /v "HideSystray" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "SecurityHealth" /t "REG_BINARY" /d "060000000000000000000000" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth" /t "REG_EXPAND_SZ" /d "%%windir%%\system32\SecurityHealthSystray.exe" /f
goto :virusback
:virusmenu3
cls
title Scheduled Scan - Windows Defender
echo ==================================================================
echo 0. Disable
echo 1. Enable (Default)
echo +. Return to Upper Menu
echo ==================================================================
set /p avrsub=^> 
if [%avrsub%] equ [0] goto :virusm3off
if [%avrsub%] equ [1] goto :virusm3on
if [%avrsub%] equ [+] goto :virusback
goto :virusmenu3
:virusm3off
schtasks /change /disable /tn "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan"
goto :virusback
:virusm3on
schtasks /change /enable /tn "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan"
goto :virusback
:virusmenu4
cls
title Real-time Protection - Windows Defender
echo ==================================================================
echo 0. Disable
echo 1. Enable (Default)
echo +. Return to Upper Menu
echo ==================================================================
set /p avrsub=^> 
if [%avrsub%] equ [0] goto :virusm4off
if [%avrsub%] equ [1] goto :virusm4on
if [%avrsub%] equ [+] goto :virusback
goto :virusmenu4
:virusm4off
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t "REG_DWORD" /D "0x00000001" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t "REG_DWORD" /D "0x00000001" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /t "REG_DWORD" /D "0x00000001" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableScanOnRealtimeEnable" /t "REG_DWORD" /D "0x00000001" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WinDefend" /v "Start" /t "REG_DWORD" /D "0x00000004" /f
goto :virusback
:virusm4on
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /f
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WinDefend" /v "Start" /t "REG_DWORD" /d "0x00000002" /f
goto :virusback
:virusback
set avrmenu=
set avrsub=
goto :virusmain
:advancemain
cls
title Manage Windows Maintenance
echo ==================================================================
echo 1. Manage Super Prefetch
echo 2. Manage Disk Defragment
echo 3. Manage Diagnostic
echo 4. Manage Auto Maintenance
echo +. Return to Main Menu
echo ==================================================================
set /p manmenu=^> 
if [%manmenu%] equ [1] goto :advancemenu1
if [%manmenu%] equ [2] goto :advancemenu2
if [%manmenu%] equ [3] goto :advancemenu3
if [%manmenu%] equ [4] goto :advancemenu4
if [%manmenu%] equ [+] goto :manageback
goto :advancemain
:advancemenu1
cls
title Super Prefetch - Windows Maintenance
echo ==================================================================
echo 0. Disable
echo 1. Enable (Default)
echo +. Return to Upper Menu
echo ==================================================================
set /p mansub=^> 
if [%mansub%] equ [0] goto :advancem1off
if [%mansub%] equ [1] goto :advancem1on
if [%mansub%] equ [+] goto :advanceback
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
set /p mansub=^> 
if [%mansub%] equ [0] goto :advancem2off
if [%mansub%] equ [1] goto :advancem2on
if [%mansub%] equ [+] goto :advanceback
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
set /p mansub=^> 
if [%mansub%] equ [0] goto :advancem3off
if [%mansub%] equ [1] goto :advancem3on
if [%mansub%] equ [+] goto :advanceback
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
set /p mansub=^> 
if [%mansub%] equ [0] goto :advancem4off
if [%mansub%] equ [1] goto :advancem4on
if [%mansub%] equ [+] goto :advanceback
goto :advancemenu4
:advancem4off
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /t "REG_DWORD" /d "0x00000001" /f
goto :advanceback
:advancem4on
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /f
goto :advanceback
:advanceback
set manmenu=
set mansub=
goto :advancemain
:miscmain
cls
title Windows Accessibility
echo ==================================================================
echo 1. Windows Picture Viewer
echo 2. Move Temporary Files to Ramdisk
echo 3. Move User Profile Data
echo 4. Context Menu (Windows 11)
echo 5. CPU Microcode Update
echo +. Return to Main Menu
echo ==================================================================
set /p mscmenu=^> 
if [%mscmenu%] equ [1] goto :miscmenu1
if [%mscmenu%] equ [2] goto :miscmenu2
if [%mscmenu%] equ [3] goto :miscmenu3
if [%mscmenu%] equ [4] goto :miscmenu4
if [%mscmenu%] equ [5] goto :miscmenu5
if [%mscmenu%] equ [+] goto :manageback
goto :miscmain
:miscmenu1
cls
title Windows Picture Viewer - Windows Accessibility
echo ==================================================================
echo Processing...
echo ==================================================================
set viewasso="bmp Bitmap" "dib Bitmap" "gif Gif" "jfif JFIF" "jpe Jpeg" "jpeg Jpeg" "jpg Jpeg" "png Png" "tiff Tiff" "tif Tiff" "wdp Wdp"
for %%a in (%viewasso%) do (for /f "tokens=1-2 delims= " %%i in (%%a) do (call :miscm1asso %%i %%j))
set viewcomm="Bitmap imageres 70" "JFIF imageres 72" "Jpeg imageres 72" "Png imageres 71" "Tiff imageres 122" "Wdp wmphoto -400"
for %%a in (%viewcomm%) do (for /f "tokens=1-3 delims= " %%i in (%%a) do (call :miscm1comm %%i %%j %%k))
set viewname="Bitmap 6" "JFIF 5" "Jpeg 5" "Png 7" "Tiff 8"
for %%a in (%viewname%) do (for /f "tokens=1-2 delims= " %%i in (%%a) do (call :miscm1name %%i %%j))
for %%a in (JFIF Jpeg Wdp) do (call :miscm1edit %%a)
for %%a in (JFIF Jpeg Tiff Wdp) do (call :miscm1open %%a)
goto :miscback
:miscm1asso
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".%1" /t "REG_SZ" /d "PhotoViewer.FileAssoc.%2" /f
exit /b
:miscm1comm
reg add "HKCR\PhotoViewer.FileAssoc.%1" /v "ImageOptionFlags" /t "REG_DWORD" /d "0x00000001" /f
reg add "HKCR\PhotoViewer.FileAssoc.%1\shell\open\command" /ve /t "REG_EXPAND_SZ" /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f
reg add "HKCR\PhotoViewer.FileAssoc.%1\shell\open\DropTarget" /v "Clsid" /t "REG_SZ" /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f
reg add "HKCR\PhotoViewer.FileAssoc.%1\DefaultIcon" /ve /t "REG_SZ" /d "%%SystemRoot%%\System32\%2.dll,%3" /f
exit /b
:miscm1name
reg add "HKCR\PhotoViewer.FileAssoc.%1" /v "FriendlyTypeName" /t "REG_EXPAND_SZ" /d "@%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll,-305%2" /f
exit /b
:miscm1edit
reg add "HKCR\PhotoViewer.FileAssoc.%1" /v "EditFlags" /t "REG_DWORD" /d "0x00010000" /f
exit /b
:miscm1open
reg add "HKCR\PhotoViewer.FileAssoc.%1\shell\open" /v "MuiVerb" /t "REG_EXPAND_SZ" /d "@%%ProgramFiles%%\Windows Photo Viewer\photoviewer.dll,-3043" /f
exit /b
:miscmenu2
cls
title Move Temporary Files to Ramdisk - Windows Accessibility
echo ==================================================================
echo Processing...
echo ==================================================================
for /f %%a in ('wmic logicaldisk where "VolumeName='RAMDISK'" get Caption ^| find ":"') do (set ramdisk=%%a\Temp)
if not exist "%ramdisk%" goto :miscback
call :symboforce "%localappdata%\Temp" "%ramdisk%"
call :symboforce "%systemroot%\Temp" "%ramdisk%"
goto :miscback
:miscmenu3
cls
title Move User Profile Data - Windows Accessibility
echo ==================================================================
echo Pleas enter the disk label
echo For example, D or D: or D:\
echo ==================================================================
set /p mscsub=^> 
set drive=%mscsub:~0,1%:
if not exist "%drive%" goto :miscback
call :symbolink "%UserProfile%\Desktop" "%drive%\Home\Desktop"
call :symbolink "%UserProfile%\Documents" "%drive%\Home\Documents"
call :symbolink "%UserProfile%\Downloads" "%drive%\Home\Downloads"
call :symbolink "%UserProfile%\Music" "%drive%\Home\Music"
call :symbolink "%UserProfile%\Pictures" "%drive%\Home\Pictures"
call :symbolink "%UserProfile%\Saved Games" "%drive%\Home\Saved Games"
call :symbolink "%UserProfile%\Videos" "%drive%\Home\Videos"
goto :miscback
:miscmenu4
cls
title Context Menu (Windows 11) - Windows Accessibility
echo ==================================================================
echo 0. Modern Mode (Default)
echo 1. Legacy Mode
echo +. Return to Upper Menu
echo ==================================================================
set /p mscsub=^> 
if [%mscsub%] equ [0] goto :miscm4off
if [%mscsub%] equ [1] goto :miscm4on
if [%mscsub%] equ [+] goto :miscback
goto :miscmenu4
:miscm4off
reg delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f
goto :miscback
:miscm4on
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /ve /d "" /f
goto :miscback
:miscmenu5
cls
title CPU Microcode Update - Windows Accessibility
echo ==================================================================
echo 0. Restore from Backup
echo 1. Remove and Backup
echo +. Return to Upper Menu
echo ==================================================================
set /p mscsub=^> 
if [%mscsub%] equ [0] goto :miscm5off
if [%mscsub%] equ [1] goto :miscm5on
if [%mscsub%] equ [+] goto :miscback
goto :miscmenu5
:miscm5off
if not exist "%cpuback%" goto :miscback
powershell -Command "Expand-Archive -Force -Path '%cpuback%' -DestinationPath '%systemroot%\System32'"
goto :miscback
:miscm5on
takeown /f "%amdcpu%" && "icacls %amdcpu%" /grant Administrators:F
takeown /f "%intlcpu%" && "icacls %intlcpu%" /grant Administrators:F
powershell -Command "Compress-Archive -Force -Path '%amdcpu%','%intlcpu%' -DestinationPath '%cpuback%'"
del "%amdcpu%" "%intlcpu%" /f /q
goto :miscback
:symbolink
if not exist "%~1" goto :symbomake
rd %1 2>nul && goto :symbomake
xcopy %1 %2 /e /i /h
:symboforce
rd %1 /s /q
:symbomake
mklink /d %1 %2
exit /b
:miscback
set mscmenu=
set mscsub=
goto :miscmain
