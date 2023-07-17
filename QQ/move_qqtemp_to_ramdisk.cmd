@echo off
net session >nul 2>&1 && goto :main
mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c pushd ""%~dp0"" && ""%~s0","","runas",1)(window.close)
exit
:main
for /f %%a in ('wmic logicaldisk where "VolumeName='ramdisk'" get Caption ^| find ":"') do (set ramdisk=%%a\Temp)
if not defined ramdisk goto :exit
echo ======================================================
echo Prevent installing QQ Guild? (Y/y)
echo ======================================================
set /p act=^> 
for /f "tokens=2 delims==" %%a in ('wmic process where name^="qq.exe" get executablepath /value') do (set app=%%a)
if defined app taskkill /f /im qq.exe
set data=%public%\Documents\Tencent\QQ\UserDataInfo.ini
set user=%userprofile%\Documents\Tencent Files
set tenc=%appdata%\Tencent
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
cd /d %path%
goto :process
:document
if not exist "%user%" md "%user%"
cd /d %user%
:process
for /d %%a in (*) do (call :profile "%%a")
if not exist "%tenc%" md "%tenc%"
cd /d %tenc%
rd /s /q Logs 2>nul
rd /s /q QQTempSys 2>nul
rd /s /q QQ\Temp 2>nul
rd /s /q QQ\webkit_cache 2>nul
mklink /d Logs %ramdisk%
mklink /d QQTempSys %ramdisk%
mklink /d QQ\webkit_cache %ramdisk%
if /i [%act%] equ [y] (
    md QQ\Temp
    icacls QQ\Temp /deny Everyone:(F)
) else (
    mklink /d QQ\Temp %ramdisk%
)
cd Users
for /d %%a in (*) do (call :appdata "%%a")
goto :exit
:appdata
cd %1
rd /s /q QQ\WinTemp 2>nul
mklink /d QQ\WinTemp %ramdisk%
cd..
exit /b
:profile
cd %1
rd /s /q Audio 2>nul
rd /s /q FileRecv 2>nul
rd /s /q Image 2>nul
rd /s /q Video 2>nul
mklink /d Audio %ramdisk%
mklink /d FileRecv %ramdisk%
mklink /d Image %ramdisk%
mklink /d Video %ramdisk%
if %1 equ "All Users" cd.. && exit /B
rd /s /q Ads 2>nul
rd /s /q AppWebCache 2>nul
rd /s /q OfflinePackage 2>nul
mklink /d Ads %ramdisk%
mklink /d AppWebCache %ramdisk%
mklink /d OfflinePackage %ramdisk%
cd..
exit /b
:exit
if defined app start "" "%app%"
timeout /t 5
