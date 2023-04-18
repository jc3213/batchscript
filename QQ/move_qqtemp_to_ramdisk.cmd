@ECHO OFF
FOR /F %%I in ('wmic logicaldisk where "VolumeName='RAMDISK'" get Caption ^| find ":"') DO SET Ramdisk=%%I\Temp
SET Profile=%Public%\Documents\Tencent\QQ\UserDataInfo.ini
IF NOT EXIST "%Profile%" GOTO :Document
FOR /F "TOKENS=1,2 DELIMS==" %%I IN ('type %Profile%') DO (
    IF %%I EQU UserDataSavePathType SET Type=%%J
    IF %%I EQU UserDataSavePath SET Path=%%J
)
IF %Type% EQU 1 GOTO :Document
IF %Type% EQU 2 GOTO :Defined
GOTO :Exit
:Defined
CD /D %Path%
IF %ErrorLevel% EQU 0 GOTO :Process
:Document
CD /D %UserProfile%\Documents\Tencent Files
:Process
FOR /D %%I IN (*) DO (CALL :Profile "%%I")
CD /D %AppData%\Tencent
RD /S /Q Logs 2>NUL
RD /S /Q QQTempSys 2>NUL
RD /S /Q QQ\Temp 2>NUL
RD /S /Q QQ\webkit_cache 2>NUL
MKLINK /D Logs %Ramdisk%
MKLINK /D QQTempSys %Ramdisk%
MKLINK /D QQ\Temp %Ramdisk%
MKLINK /D QQ\webkit_cache %Ramdisk%
CD Users
FOR /D %%I IN (*) DO (CALL :AppData "%%I")
GOTO :Exit
:AppData
CD %1
RD /S /Q QQ\WinTemp 2>NUL
MKLINK /D QQ\WinTemp %Ramdisk%
CD..
EXIT /B
:Profile
CD %1
RD /S /Q Audio 2>NUL
RD /S /Q FileRecv 2>NUL
RD /S /Q Image 2>NUL
RD /S /Q Video 2>NUL
MKLINK /D Audio %Ramdisk%
MKLINK /D FileRecv %Ramdisk%
MKLINK /D Image %Ramdisk%
MKLINK /D Video %Ramdisk%
IF %1 EQU "All Users" CD.. && EXIT /B
RD /S /Q Ads 2>NUL
RD /S /Q AppWebCache 2>NUL
RD /S /Q OfflinePackage 2>NUL
MKLINK /D Ads %Ramdisk%
MKLINK /D AppWebCache %Ramdisk%
MKLINK /D OfflinePackage %Ramdisk%
CD..
EXIT /B
:Exit
TIMEOUT /T 5
