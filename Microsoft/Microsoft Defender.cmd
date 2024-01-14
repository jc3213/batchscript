@echo off
:virusmain
cls
title Manage Windows Defender
echo ==================================================================
echo 1. Manage Context Menu
echo 2. Manage System Tray Icon
echo 3. Manage Scheduled Scan
echo 4. Manage Real-time Protection
if exist "%~1" echo +. Return to Main Menu
echo ==================================================================
set /p sec=^> 
if [%sec%] equ [1] goto :virusmenu1
if [%sec%] equ [2] goto :virusmenu2
if [%sec%] equ [3] goto :virusmenu3
if [%sec%] equ [4] goto :virusmenu4
if [%sec%] equ [+] goto :manageback
goto :virusmain
:virusmenu1
cls
title Context Menu - Windows Defender
echo ==================================================================
echo 0. Disable
echo 1. Enable (Default)
echo +. Return to Upper Menu
echo ==================================================================
set /p sub=^> 
if [%sub%] equ [0] goto :virusm1off
if [%sub%] equ [1] goto :virusm1on
if [%sub%] equ [+] goto :virusback
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
set /p sub=^> 
if [%sub%] equ [0] goto :virusm2off
if [%sub%] equ [1] goto :virusm2on
if [%sub%] equ [+] goto :virusback
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
set /p sub=^> 
if [%sub%] equ [0] goto :virusm3off
if [%sub%] equ [1] goto :virusm3on
if [%sub%] equ [+] goto :virusback
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
set /p sub=^> 
if [%sub%] equ [0] goto :virusm4off
if [%sub%] equ [1] goto :virusm4on
if [%sub%] equ [+] goto :virusback
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
set sec=
set sub=
goto :virusmain
:manageback
if exist "%~1" call "%~1"
goto :virusmain
