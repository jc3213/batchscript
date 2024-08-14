@echo off
net session >nul 2>nul && goto :main
mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c pushd ""%~dp0"" && ""%~s0","","runas",1)(window.close)
exit
:main
for /f %%a in ('wmic logicaldisk where "VolumeName='ramdisk'" get Caption ^| find ":"') do (set ramdisk=%%a\Temp\QQFiles)
if not defined ramdisk goto :exit
md %ramdisk% >nul 2>nul
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
pushd %path%
goto :process
:document
if not exist "%user%" md "%user%"
pushd %user%
:process
for /d %%a in (*) do (call :profile "%%a")
if not exist "%tenc%" md "%tenc%"
pushd %tenc%
call :link Logs
call :link QQTempSys
call :link QQ\webkit_cache
call :link QQ\webkitex_cache
if /i [%act%] equ [y] (
    icacls QQ\Temp /deny Everyone:(F)
) else (
    call :link QQ\Temp
)
cd Users
for /d %%a in (*) do (call :appdata "%%a")
goto :exit
:appdata
cd %1
call :link QQ\WinTemp
cd..
exit /b
:profile
cd %1
call :link Audio
call :link FileRecv
call :link Image
call :link Video
if %1 equ "All Users" cd.. && exit /B
call :link Ads
call :link AppWebCache
call :link OfflinePackage
cd..
exit /b
:link
rd %1 2>nul || rd %1 /s /q
mklink /d "%~1" %ramdisk%
exit /b
:exit
if defined app start "" "%app%"
timeout /t 5
