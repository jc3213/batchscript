@echo off
title Computer Manufacturer
for /f "tokens=2 delims==" %%a in ('wmic cpu get Name /value') do (echo Processor:                      %%a)
for /f "tokens=2 delims==" %%b in ('wmic cpu get Manufacturer /value') do (echo CPU Manufacturer:               %%b)
for /f "tokens=2 delims==" %%a in ('wmic baseboard get Product /value') do (echo Motherboard:                    %%a)
for /f "tokens=2 delims==" %%b in ('wmic baseboard get Manufacturer /value') do (echo Motherboard Manufacturer:       %%b)
for /f "tokens=2 delims==" %%a in ('wmic path win32_videocontroller get Name /value') do (echo Graphic Card:                   %%a)
for /f "tokens=2 delims==" %%b in ('wmic path win32_videocontroller get AdapterCompatibility /value') do (echo GPU Manufacturer:               %%b)
for /f "tokens=2 delims==" %%a in ('wmic memorychip get Capacity /value') do (call :capacity %%a)
for /f "tokens=2 delims==" %%b in ('wmic memorychip get Manufacturer /value') do (echo Memory Manufacturer:            %%b)
for /f "tokens=2 delims==" %%c in ('wmic memorychip get MemoryType /value') do (call :memory %%c)
for /f "tokens=2 delims==" %%d in ('wmic memorychip get Speed /value') do (call :memspeed %%d)
timeout /t 5
exit
:memory
if %1 equ 24 echo Memory Type:                    DDR 3
if %1 equ 26 echo Memory Type:                    DDR 4
if %1 equ 30 echo Memory Type:                    DDR 5
exit /b
:capacity
echo Memory Capacity:                %1 Bytes
exit /b
:memspeed
echo Memory Speed:                   %1 MHz
exit /b
