@echo off
net session >nul 2>nul && goto :admin
mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c pushd ""%~dp0"" && ""%~s0","","runas",1)(window.close)
exit
:admin
for /f %%a in ('wmic logicaldisk where "VolumeName='ramdisk'" get Caption ^| find ":"') do (set ramdisk="%%~a\Temp\")
if not defined ramdisk goto :exit
md %ramdisk% >nul 2>nul
for /f "tokens=2 delims==" %%a in ('wmic process where name^="qq.exe" get executablepath /value') do (set app=%%a)
if defined app taskkill /f /im qq.exe
:appdata
call :link "%appdata%\QQ\Cache"
call :link "%appdata%\QQ\Code Cache"
call :link "%appdata%\QQ\DawnCache"
call :link "%appdata%\QQ\dynamic_package"
call :link "%appdata%\QQ\GPUCache"
call :link "%appdata%\QQ\GPUCache"
call :link "%appdata%\QQ\packages"
call :link "%appdata%\QQ\Partitions"
call :link "%appdata%\QQ\qqgame"
:profile
set data=%public%\Documents\Tencent\QQ\UserDataInfo.ini
set user=%userprofile%\Documents\Tencent Files
if not exist "%data%" goto :document
for /f "tokens=1,2 delims==" %%a in ('type %data%') do (
    if %%a equ UserDataSavePathType set type=%%b
    if %%a equ UserDataSavePath set path=%%b
)
if [%type%] equ [1] goto :document
if [%type%] equ [2] goto :defined
goto :exit
:defined
if not exist "%path%" md "%path%"
pushd %path%
goto :process
:document
if not exist "%user%" md "%user%"
pushd %user%
:process
for /d %%a in (*) do (call :users "%%~a")
goto :exit
:users
if [%~1] equ [nt_qq] goto :global
call :link "%1\nt_qq\nt_temp"
call :link "%1\nt_qq\nt_data\Emoji"
call :link "%1\nt_qq\nt_data\File"
call :link "%1\nt_qq\nt_data\Pic"
call :link "%1\nt_qq\nt_data\Video"
exit /b
:global
call :link "%1\global\nt_temp"
exit /b
:link
rd %1 2>nul || rd %1 /s /q
mklink /d %1 %ramdisk%
exit /b
:exit
if defined app start "" "%app%"
timeout /t 5
