@echo off
:powermain
cls
title Manage Windows Power Plan
echo ==================================================================
echo 1. Manage Hibernation
echo 2. Manage Disk Idle Timeout
echo 3. Manage Processor Maximum P-state
echo 4. Manage Processor Minimum P-state
echo 5. Manage Heterogeneous Thread Policy
if exist "%~1" echo +. Return to Main Menu
echo ==================================================================
set /p sec=^> 
if [%sec%] equ [1] goto :powermenu1
if [%sec%] equ [2] goto :powermenu2
if [%sec%] equ [3] goto :powermenu3
if [%sec%] equ [4] goto :powermenu4
if [%sec%] equ [5] goto :powermenu5
if [%sec%] equ [+] goto :manageback
goto :powermain
:powermenu1
cls
title Hibernation - Power Plan
echo ==================================================================
echo 0. Disable
echo 1. Enable
echo +. Return to Upper Menu
echo ==================================================================
set /p sub=^> 
if [%sub%] equ [0] call :powerm1app off
if [%sub%] equ [1] call :powerm1app on
if [%sub%] equ [+] goto :powerback
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
set /p sub=^> 
if [%sub%] equ [0] call :powerm2app 0
if [%sub%] equ [1] call :powerm2app 20
if [%sub%] equ [+] goto :powerback
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
set /p sub=^> 
echo %sub%| findstr /r /c:"^[5-9][0-9]$" /c:"^100$" >nul
if %errorlevel% equ 1 set sub=100
call :powerm34app MAX %sub%
:powermenu4
cls
title Processor Minimum P-state - Power Plan
echo ==================================================================
echo Minimum: 0 (Default)
echo Maximum: 100
echo ==================================================================
set /p sub=^> 
echo %sub%| findstr /r /c:"^[0-9]$" /c:"^[1-9][0-9]$" /c:"^100$" >nul
if %errorlevel% equ 1 set sub=0
call :powerm34app MIN %sub%
:powermenu5
cls
title Heterogeneous Thread Policy - Power Plan
echo ==================================================================
echo 0. Default (Automatic)
echo 1. Prefer performant processors
echo +. Return to Upper Menu
echo ==================================================================
set /p sub=^> 
if [%sub%] equ [0] call :powerm5app 5
if [%sub%] equ [1] call :powerm5app 2
if [%sub%] equ [+] goto :powerback
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
:powerback
set sec=
set sub=
goto :powermain
:manageback
if exist "%~1" call "%~1"
goto :powermain
