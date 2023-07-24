rem Sub Menu Template
:label
cls
echo ==================================================================
echo    Title
echo ==================================================================
echo 1. 
echo 2. 
echo 3. 
echo 0. Back to main menu
echo ==================================================================
set /p sub=^> 
if [%sub%] equ [1] goto :llabell1
if [%sub%] equ [2] goto :llabell2
if [%sub%] equ [3] goto :llabell3
if [%upd%] equ [0] call :menu main
goto :label
rem Comfirm Change Template
:llabell1
cls
echo ==================================================================
echo    Title
echo ==================================================================
echo 1. 
echo 2. 
echo 0. Back to previous menu
echo ==================================================================
set /p act=^> 
if [%act%] equ [1] goto :llaall1on
if [%act%] equ [2] goto :llaall1off
if [%act%] equ [0] call :menu label
goto :llabell1
rem Function Template
:llaall1on
call :menu main
:llaall1off
call :menu main
