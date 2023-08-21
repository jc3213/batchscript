@echo off
set main="%~1"
:antivirus
cls
title Manage Windows Defender
echo ==================================================================
echo 1. Manage Context Menu
echo 2. Manage System Tray Icon
echo 3. Manage Scheduled Scan
echo 4. Manage Real-time Protection
if exist %main% echo +. Return to Main Menu
echo ==================================================================
set /p deact=^> 
if [%deact%] equ [1] goto :demenu1
if [%deact%] equ [2] goto :demenu2
if [%deact%] equ [3] goto :demenu3
if [%deact%] equ [4] goto :demenu4
if [%deact%] equ [+] goto :mainmenu
goto :antivirus
:demenu1
cls
title Context Menu - Windows Defender
echo ==================================================================
echo 0. Disable
echo 1. Enable (Default)
echo +. Return to Upper Menu
echo ==================================================================
set /p desub=^> 
if [%desub%] equ [0] goto :dem1off
if [%desub%] equ [1] goto :dem1on
if [%desub%] equ [+] goto :return
goto :demenu1
:dem1off
reg delete "HKCR\*\shellex\ContextMenuHandlers\EPP" /ve /f
reg delete "HKCR\Drive\shellex\ContextMenuHandlers\EPP" /ve /f
reg delete "HKCR\Directory\shellex\ContextMenuHandlers\EPP" /ve /f
reg delete "HKCR\CLSID\{09A47860-11B0-4DA5-AFA5-26D86198A780}\InprocServer32" /ve /f
goto :return
:dem1on
reg add "HKCR\*\shellex\ContextMenuHandlers\EPP" /ve /t "REG_SZ" /d "{09A47860-11B0-4DA5-AFA5-26D86198A780}" /f
reg add "HKCR\Drive\shellex\ContextMenuHandlers\EPP" /ve /t "REG_SZ" /d "{09A47860-11B0-4DA5-AFA5-26D86198A780}" /f
reg add "HKCR\Directory\shellex\ContextMenuHandlers\EPP" /ve /t "REG_SZ" /d "{09A47860-11B0-4DA5-AFA5-26D86198A780}" /f
reg add "HKCR\CLSID\{09A47860-11B0-4DA5-AFA5-26D86198A780}\InprocServer32" /ve /t "REG_SZ" /d "%ProgramFiles%\Windows Defender\shellext.dll" /f
goto :return
:demenu2
cls
title System Tray Icon - Windows Defender
echo ==================================================================
echo 0. Disable
echo 1. Enable (Default)
echo +. Return to Upper Menu
echo ==================================================================
set /p desub=^> 
if [%desub%] equ [0] goto :dem2off
if [%desub%] equ [1] goto :dem2on
if [%desub%] equ [+] goto :return
goto :demenu2
:dem2off
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray" /v "HideSystray" /t "REG_DWORD" /D "0x00000001" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "SecurityHealth" /t "REG_BINARY" /D "07000000CD54F699D161D900" /f
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth" /f
goto :return
:dem2on
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray" /v "HideSystray" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "SecurityHealth" /t "REG_BINARY" /d "060000000000000000000000" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth" /t "REG_EXPAND_SZ" /d "%%windir%%\system32\SecurityHealthSystray.exe" /f
goto :return
:demenu3
cls
title Scheduled Scan - Windows Defender
echo ==================================================================
echo 0. Disable
echo 1. Enable (Default)
echo +. Return to Upper Menu
echo ==================================================================
set /p desub=^> 
if [%desub%] equ [0] goto :dem3off
if [%desub%] equ [1] goto :dem3on
if [%desub%] equ [+] goto :return
goto :demenu3
:dem3off
schtasks /change /disable /tn "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan"
goto :return
:dem3on
schtasks /change /enable /tn "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan"
goto :return
:demenu4
cls
title Real-time Protection - Windows Defender
echo ==================================================================
echo 0. Disable
echo 1. Enable (Default)
echo +. Return to Upper Menu
echo ==================================================================
set /p desub=^> 
if [%desub%] equ [0] goto :dem4off
if [%desub%] equ [1] goto :dem4on
if [%desub%] equ [+] goto :return
goto :demenu4
:dem4off
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t "REG_DWORD" /D "0x00000001" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t "REG_DWORD" /D "0x00000001" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /t "REG_DWORD" /D "0x00000001" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableScanOnRealtimeEnable" /t "REG_DWORD" /D "0x00000001" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WinDefend" /v "Start" /t "REG_DWORD" /D "0x00000004" /f
goto :return
:dem4on
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /f
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WinDefend" /v "Start" /t "REG_DWORD" /d "0x00000002" /f
goto :return
:mainmenu
if exist %main% call %main%
goto :antivirus
:return
set deact=
set desub=
timeout /t 5
goto :antivirus
