@echo off
net session >nul 2>&1 && goto :admin
mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c ""%~s0"" %*","","runas",1)(window.close)
exit
:admin
set ppmenu="%~dp0Windows Power Plan.cmd"
set wumenu="%~dp0Windows Update.cmd"
set egmenu="%~dp0Microsoft Edge.cmd"
set demenu="%~dp0Windows Defender.cmd"
set mnmenu="%~dp0Windows Maintenance.cmd"
set avmenu="%~dp0Windows Accessibility.cmd"
:mainmenu
cls
title Windows Management Tweaks
echo ==================================================================
if exist %ppmenu% echo 1. Windows Power Plan
if exist %wumenu% echo 2. Windows Update
if exist %egmenu% echo 3. Microsoft Edge
if exist %demenu% echo 4. Windows Defender
if exist %mnmenu% echo 5. Windows Maintenance
if exist %avmenu% echo 6. Windows Accessibility
echo ==================================================================
set /p main=^> 
if [%main%] equ [1] call :external %ppmenu%
if [%main%] equ [2] call :external %wumenu%
if [%main%] equ [3] call :external %egmenu%
if [%main%] equ [4] call :external %demenu%
if [%main%] equ [5] call :external %mnmenu%
if [%main%] equ [6] call :external %avmenu%
goto :return
:external
if exist %1 call %1 "%~s0"
goto :return
:return
set main=
goto :mainmenu
