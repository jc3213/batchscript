@echo off
net session >nul 2>&1 && goto :main
mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c pushd ""%~dp0"" && ""%~s0","","runas",1)(window.close)
exit
:main
for /f %%a in ('wmic logicaldisk where "VolumeName='ramdisk'" get Caption ^| find ":"') do (set ramdisk=%%a\Temp)
if not defined ramdisk goto :exit
for /f "tokens=2 delims==" %%a in ('wmic process where name^="qq.exe" get executablepath /value') do (set app=%%a)
if defined app taskkill /f /im qq.exe
set profile=%Public%\Documents\Tencent\QQ\UserDataInfo.ini
if not exist "%profile%" goto :document
for /f "tokens=1,2 delims==" %%a in ('type %profile%') do (
    if %%a equ UserDataSavePathType set type=%%b
    if %%a equ UserDataSavePath set path=%%b
)
if %type% equ 1 goto :document
if %type% equ 2 goto :defined
goto :exit
:defined
cd /d %path%
if %errorlevel% equ 0 goto :process
:document
cd /d %Userprofile%\Documents
md "Tencent Files" 2>nul
cd "Tencent Files"
:process
for /d %%a in (*) do (call :profile "%%a")
cd /d %appdata%
md Tencent 2>nul
cd Tencent
rd /s /q Logs 2>nul
rd /s /q QQTempSys 2>nul
rd /s /q QQ\Temp 2>nul
rd /s /q QQ\webkit_cache 2>nul
mklink /d Logs %ramdisk%
mklink /d QQTempSys %ramdisk%
mklink /d QQ\webkit_cache %ramdisk%
md QQ\Temp
icacls QQ\Temp /deny Everyone:(F)
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
