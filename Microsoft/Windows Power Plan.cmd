@echo off
:powerplan
cls
title Manage Windows Power Plan
echo ==================================================================
echo 1. Manage Hibernation
echo 2. Manage Disk Idle Timeout
echo 3. Manage Heterogeneous Thread Policy
echo 4. Manage Processor Maximum P-state
echo 5. Manage Processor Minimum P-state
if exist "%~1" echo *. Back to main menu
echo ==================================================================
set /p ppact=^> 
if [%ppact%] equ [1] goto :ppmenu1
if [%ppact%] equ [2] goto :ppmenu2
if [%ppact%] equ [3] goto :ppmenu3
if [%ppact%] equ [4] goto :ppmenu4
if [%ppact%] equ [5] goto :ppmenu5
if [%ppact%] equ [*] goto :mainmenu
goto :powerplan
:ppmenu1
cls
title Hibernation - Power Plan
echo ==================================================================
echo 0. Disable
echo 1. Enable
echo *. Return to upper menu
echo ==================================================================
set /p ppsub=^> 
if [%ppsub%] equ [0] goto :ppm1off
if [%ppsub%] equ [1] goto :ppm1on
if [%ppsub%] equ [*] goto :return
goto :ppmenu1
:ppm1on
powercfg /hibernate on
goto :return
:ppm1off
powercfg /hibernate off
goto :return
:ppmenu2
cls
title Disk Idle Timeout - Power Plan
echo ==================================================================
echo 0. Never
echo 1. Default (20 minutes)
echo *. Return to upper menu
echo ==================================================================
set /p ppsub=^> 
if [%ppsub%] equ [0] goto :ppm2off
if [%ppsub%] equ [1] goto :ppm2on
if [%ppsub%] equ [*] goto :return
goto :ppmenu2
:ppm2on
powercfg /change disk-timeout-ac 20
powercfg /change disk-timeout-dc 20
goto :return
:ppm2off
powercfg /change disk-timeout-ac 0
powercfg /change disk-timeout-dc 0
goto :return
:ppmenu3
cls
title Heterogeneous Thread Policy - Power Plan
echo ==================================================================
echo 0. Default (Automatic)
echo 1. Prefer performant processors
echo *. Return to upper menu
echo ==================================================================
set /p ppsub=^> 
if [%ppsub%] equ [0] goto :ppm3off
if [%ppsub%] equ [1] goto :ppm3on
if [%ppsub%] equ [*] goto :return
goto :ppmenu3
:ppm3on
powercfg /setacvalueindex scheme_current sub_processor SCHEDPOLICY 2
powercfg /setacvalueindex scheme_current sub_processor SHORTSCHEDPOLICY 2
powercfg /setactive scheme_current
goto :return
:ppm3off
powercfg /setacvalueindex scheme_current sub_processor SCHEDPOLICY 5
powercfg /setacvalueindex scheme_current sub_processor SHORTSCHEDPOLICY 5
powercfg /setactive scheme_current
goto :return
:ppmenu4
cls
title Processor Maximum P-state - Power Plan
echo ==================================================================
echo Minimum: 50
echo Maximum: 100 (Default)
echo ==================================================================
set /p ppsub=^> 
echo %ppsub%| findstr /r /c:"^[5-9][0-9]$" /c:"^100$" >nul
if %errorlevel% equ 1 set ppsub=100
powercfg /setacvalueindex scheme_current sub_processor PROCTHROTTLEMAX %ppsub%
powercfg /setactive scheme_current
goto :return
:ppmenu5
cls
title Processor Minimum P-state - Power Plan
echo ==================================================================
echo Minimum: 0 (Default)
echo Maximum: 100
echo ==================================================================
set /p ppsub=^> 
echo %ppsub%| findstr /r /c:"^[0-9]$" /c:"^[1-9][0-9]$" /c:"^100$" >nul
if %errorlevel% equ 1 set ppsub=0
powercfg /setacvalueindex scheme_current sub_processor PROCTHROTTLEMIN %ppsub%
powercfg /setactive scheme_current
goto :return
:mainmenu
if exist "%~1" call "%~1"
:return
set ppact=
set ppsub=
goto :powerplan
