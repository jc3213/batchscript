@ECHO OFF
FOR /F "TOKENS=1,2 DELIMS==" %%I IN ('type %Public%\Documents\Tencent\QQ\UserDataInfo.ini') DO (
    IF %%I EQU UserDataSavePathType SET Type=%%J
    IF %%I EQU UserDataSavePath SET Save=%%J
)
IF %Type% EQU 1 (
    SET Folder="%UserProfile%\Documents\Tencent Files"
) ELSE IF DEFINED Save (
    SET Folder="%Save%"
) ELSE (
    SET Folder="%~DP0"
)
CD /D %Folder%
FOR /D %%I IN (*) DO (
    IF "%%I" NEQ "All Users" CALL :Profile "%%I"
)
:AppData
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
TIMEOUT /T 5
EXIT
:AppData
CD /D %1
RD /S /Q QQ\WinTemp 2>NUL
MKLINK /D QQ\WinTemp "R:\temp"
CD..
EXIT /B
:Profile
CD %1
RD /S /Q Ads 2>NUL
RD /S /Q AppWebCache 2>NUL
RD /S /Q Audio 2>NUL
RD /S /Q FileRecv 2>NUL
RD /S /Q OfflinePackage 2>NUL
RD /S /Q Image 2>NUL
RD /S /Q Video 2>NUL
MKLINK /D Ads "R:\Temp"
MKLINK /D AppWebCache "R:\Temp"
MKLINK /D Audio "R:\Temp"
MKLINK /D FileRecv "R:\Temp"
MKLINK /D OfflinePackage "R:\Temp"
MKLINK /D Image "R:\Temp"
MKLINK /D Video "R:\Temp"
CD..
EXIT /B
