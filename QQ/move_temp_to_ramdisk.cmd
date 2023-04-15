@ECHO OFF
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
MKLINK /D Logs "R:\Temp"
MKLINK /D QQTempSys "R:\Temp"
MKLINK /D QQ\Temp "R:\Temp"
MKLINK /D QQ\webkit_cache "R:\Temp"
CD Users
FOR /D %%I IN (*) DO (CALL :AppData "%%I")
GOTO :Exit
:AppData
CD %1
RD /S /Q QQ\WinTemp 2>NUL
MKLINK /D QQ\WinTemp "R:\temp"
CD..
EXIT /B
:Profile
CD %1
RD /S /Q Audio 2>NUL
RD /S /Q FileRecv 2>NUL
RD /S /Q Image 2>NUL
RD /S /Q Video 2>NUL
MKLINK /D Audio "R:\Temp"
MKLINK /D FileRecv "R:\Temp"
MKLINK /D Image "R:\Temp"
MKLINK /D Video "R:\Temp"
IF %1 EQU "All Users" CD.. && EXIT /B
RD /S /Q Ads 2>NUL
RD /S /Q AppWebCache 2>NUL
RD /S /Q OfflinePackage 2>NUL
MKLINK /D Ads "R:\Temp"
MKLINK /D AppWebCache "R:\Temp"
MKLINK /D OfflinePackage "R:\Temp"
CD..
EXIT /B
:Exit
TIMEOUT /T 5
