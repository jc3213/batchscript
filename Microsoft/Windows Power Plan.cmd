@echo off
set main="%~1"
:powerplan
cls
title Manage Windows Power Plan
echo ==================================================================
echo 1. Manage Hibernation
echo 2. Manage Disk Idle Timeout
echo 3. Manage Processor Maximum P-state
echo 4. Manage Processor Minimum P-state
echo 5. Manage Heterogeneous Thread Policy
if exist %main% echo +. Return Main Menu
echo ==================================================================
set /p ppact=^> 
if [%ppact%] equ [1] goto :ppmenu1
if [%ppact%] equ [2] goto :ppmenu2
if [%ppact%] equ [3] goto :ppmenu3
if [%ppact%] equ [4] goto :ppmenu4
if [%ppact%] equ [5] goto :ppmenu5
if [%ppact%] equ [+] goto :mainmenu
goto :powerplan
:ppmenu1
cls
title Hibernation - Power Plan
echo ==================================================================
echo 0. Disable
echo 1. Enable
echo +. Return Upper Menu
echo ==================================================================
set /p ppsub=^> 
if [%ppsub%] equ [0] call :ppm1app off
if [%ppsub%] equ [1] call :ppm1app on
if [%ppsub%] equ [+] goto :return
goto :ppmenu1
:ppm1app
powercfg /hibernate %1
goto :return
:ppmenu2
cls
title Disk Idle Timeout - Power Plan
echo ==================================================================
echo 0. Never
echo 1. Default (20 minutes)
echo +. Return Upper Menu
echo ==================================================================
set /p ppsub=^> 
if [%ppsub%] equ [0] call :ppm2app 0
if [%ppsub%] equ [1] call :ppm2app 20
if [%ppsub%] equ [+] goto :return
goto :ppmenu2
:ppm2app
powercfg /change disk-timeout-ac %1
powercfg /change disk-timeout-dc %1
goto :return
:ppmenu3
cls
title Processor Maximum P-state - Power Plan
echo ==================================================================
echo Minimum: 50
echo Maximum: 100 (Default)
echo ==================================================================
set /p ppsub=^> 
echo %ppsub%| findstr /r /c:"^[5-9][0-9]$" /c:"^100$" >nul
if %errorlevel% equ 1 set ppsub=100
call :ppcstate PROCTHROTTLEMAX %ppsub%
:ppmenu4
cls
title Processor Minimum P-state - Power Plan
echo ==================================================================
echo Minimum: 0 (Default)
echo Maximum: 100
echo ==================================================================
set /p ppsub=^> 
echo %ppsub%| findstr /r /c:"^[0-9]$" /c:"^[1-9][0-9]$" /c:"^100$" >nul
if %errorlevel% equ 1 set ppsub=0
call :ppcstate PROCTHROTTLEMIN %ppsub%
:ppmenu5
cls
title Heterogeneous Thread Policy - Power Plan
echo ==================================================================
echo 0. Default (Automatic)
echo 1. Prefer performant processors
echo +. Return Upper Menu
echo ==================================================================
set /p ppsub=^> 
if [%ppsub%] equ [0] call :ppm5app 5
if [%ppsub%] equ [1] call :ppm5app 2
if [%ppsub%] equ [+] goto :return
goto :ppmenu5
:ppm5app
powercfg /setacvalueindex scheme_current sub_processor SCHEDPOLICY %1
powercfg /setacvalueindex scheme_current sub_processor SHORTSCHEDPOLICY %1
powercfg /setactive scheme_current
goto :return
:ppcstate
powercfg /setacvalueindex scheme_current sub_processor %1 %2
powercfg /setactive scheme_current
goto :return
:mainmenu
if exist %main% call %main%
:return
set ppact=
set ppsub=
goto :powerplan
