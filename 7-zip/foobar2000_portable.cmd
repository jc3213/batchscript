@echo off
pushd %~dp0
set /a int=0
for /f "tokens=*" %%a in ('curl https://www.foobar2000.org/download --silent ^| findstr /r /c:"/getfile/foobar2000_.*\.exe"') do (call :menu "%%a")
:menu
setlocal enabledelayedexpansion
echo ====================================================================================================
for /f "tokens=2,5,8 delims=>=" %%a in (%1) do (call :link %%a %%b %%c)
echo ====================================================================================================
:act
set /p act=^> 
set url=!link[%act%]!
set app=!name[%act%]!
setlocal disabledelayedexpansion
if not defined url goto :act
if exist %app%.exe goto :unpack
echo.
echo.
echo Downloading: %url%
curl %url% --location --silent --output %app%.exe
:unpack
echo.
echo.
echo Make Portable: %app%
for /f "tokens=1,2*" %%a in ('reg query HKLM\Software\7-Zip /V Path') do (if "%%a"=="Path" set Zip=%%c7z.exe)
"%Zip%" x "%~dp0%app%.exe" -y -x!$PLUGINSDIR -x!$R0 -x!uninstall.exe -o"%~dp0%app%"
type nul > %app%\portable_mode_enabled
echo.
echo.
echo Portable location foobar2000
echo.
echo.
timeout /t 5
exit
:link
for %%a in (%*) do (call :trim %%a)
exit /b
:trim
set /a int+=1
set link=%~1
set link[%int%]=https://www.foobar2000.org%link:getfile/=files/%
set name[%int%]=%link:~9%
echo %int%. !link[%int%]!
exit /b
