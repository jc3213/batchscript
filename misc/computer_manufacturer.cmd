@echo off
title Computer Manufacturer
for /f "tokens=1,2 delims==" %%a in ('wmic cpu get Manufacturer^,Name /value') do (call :processor "%%a" "%%b")
for /f "tokens=1,2 delims==" %%a in ('wmic baseboard get Manufacturer^,Product /value') do (call :motherboard "%%a" "%%b")
for /f "tokens=1,2 delims==" %%a in ('wmic path win32_videocontroller get AdapterCompatibility^,Name /value') do (call :graphic "%%a" "%%b")
for /f "tokens=1,2 delims==" %%a in ('wmic memorychip get Capacity^,Manufacturer^,MemoryType^,Speed /value') do (call :memory "%%a" "%%b")
timeout /t 5
exit
:processor
if %1 equ "" exit /b
if %~1 equ Manufacturer echo CPU Manufacturer:               %~2
if %~1 equ Name echo CPU Name:                       %~2
exit /b
:motherboard
if %1 equ "" exit /b
if %~1 equ Manufacturer echo Motherboard Manufacturer:       %~2
if %~1 equ Product echo Motherboard Name:               %~2
exit /b
:graphic
if %1 equ "" exit /b
if %~1 equ AdapterCompatibility echo GPU Manufacturer:               %~2
if %~1 equ Name echo GPU Name:                       %~2
exit /b
:memory
if %1 equ "" exit /b
if %~1 equ Capacity for /f %%a in ('powershell %~2/1GB') do (echo Memory Capacity:                %%a GB)
if %~1 equ Manufacturer echo Memory Manufacturer:            %~2
if %~1 equ Speed echo Memory Speed:                   %~2 MHz
if %~1 neq MemoryType exit /b
if %~2 equ 24 echo Memory Type:                    DDR 3
if %~2 equ 26 echo Memory Type:                    DDR 4
if %~2 equ 30 echo Memory Type:                    DDR 5
exit /b
