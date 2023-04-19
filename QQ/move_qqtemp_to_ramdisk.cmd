@echo off
for /F %%a in ('wmic logicaldisk where "VolumeName='RAMDISK'" get Caption ^| find ":"') do (set Ramdisk=%%a\Temp)
set Profile=%Public%\Documents\Tencent\QQ\UserDataInfo.ini
if not exist "%Profile%" goto :Document
for /F "tokens=1,2 delims==" %%a in ('type %Profile%') do (
    if %%a equ UserDataSavePathType set Type=%%b
    if %%a equ UserDataSavePath set Path=%%b
)
if %Type% equ 1 goto :Document
if %Type% equ 2 goto :Defined
goto :Exit
:Defined
cd /d %Path%
if %ErrorLevel% equ 0 goto :Process
:Document
cd /d %UserProfile%\Documents\Tencent Files
:Process
for /d %%a in (*) do (call :Profile "%%a")
cd /d %AppData%\Tencent
rd /s /q Logs 2>nul
rd /s /q QQTempSys 2>nul
rd /s /q QQ\Temp 2>nul
rd /s /q QQ\webkit_cache 2>nul
mklink /d Logs %Ramdisk%
mklink /d QQTempSys %Ramdisk%
mklink /d QQ\Temp %Ramdisk%
mklink /d QQ\webkit_cache %Ramdisk%
cd Users
for /d %%a in (*) do (call :AppData "%%a")
goto :Exit
:AppData
cd %1
rd /s /q QQ\WinTemp 2>nul
mklink /d QQ\WinTemp %Ramdisk%
CD..
exit /B
:Profile
cd %1
rd /s /q Audio 2>nul
rd /s /q FileRecv 2>nul
rd /s /q Image 2>nul
rd /s /q Video 2>nul
mklink /d Audio %Ramdisk%
mklink /d FileRecv %Ramdisk%
mklink /d Image %Ramdisk%
mklink /d Video %Ramdisk%
if %1 equ "All Users" cd.. && exit /B
rd /s /q Ads 2>nul
rd /s /q AppWebCache 2>nul
rd /s /q OfflinePackage 2>nul
mklink /d Ads %Ramdisk%
mklink /d AppWebCache %Ramdisk%
mklink /d OfflinePackage %Ramdisk%
cd..
exit /B
:Exit
timeout /t 5
