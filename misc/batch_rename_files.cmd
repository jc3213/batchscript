@echo off
if not exist %1 exit
cd /d %1
setlocal enabledelayedexpansion
set /a Seek=1
:SeekFiles
if [%Index%] equ [] set Index=1-9
for /f "tokens=*" %%a in ('dir /b /a-d') do (
    for /f "tokens=%Index% delims=-_.() " %%b in ("%%a") do (
        if %Seek% equ 1 (
            echo Option		  		%%a
            echo ===========================================================
            call :ListIndex %%b %%c %%d %%e %%f %%g %%h %%i %%j && goto :eof
        ) else if %Seek% gtr 1 (
            call :Filename "%%a" "%%b"
        )
    )
)
timeout /t 5
exit
:ListIndex
if "%1"=="" goto :SeekIndex
echo %1| findstr /r /c:"^[0-9][0-9]*$" >nul && set Symbol=** || set Symbol=
echo %Seek%		^>^>		%~1	  %Symbol%
set /a Seek+=1
for /f "tokens=1,* delims= " %%a in ("%*") do (call :ListIndex %%b)
:SeekIndex
set /p Index=Which one?  
if %Index% LSS 1 goto :SeekIndex
if %Index% GEQ %Seek% goto :SeekIndex 
goto :SeekFiles
:Filename
set String=#%~2
set Length=0
for %%k in (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) do (
    if "!String:~%%k,1!" neq "" (
        set /a Length+=%%k
        set String=!String:~%%k!
    )
)
if %Length% equ 1 (
    set Prefix=000%~2
) else if %Length% equ 2 (
    set Prefix=00%~2
) else if %Length% equ 3 (
    set Prefix=0%~2
) else (
    set Prefix=%~2
)
echo %~1        %~2        %Prefix%%~X1
ren %1 %Prefix%%~X1
exit /b
