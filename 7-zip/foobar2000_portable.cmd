@echo off
pushd %~dp0
for /f "tokens=2*" %%a in ('reg query "HKLM\Software\7-Zip" /v "Path"') do (set zip=%%b7z.exe)
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
echo.
echo.
curl %url% --location --output %app%.exe
:unpack
echo.
echo.
echo Make portable: %app%.exe
"%zip%" x "%~dp0%app%.exe" -y -x!$PLUGINSDIR -x!$R0 -x!uninstall.exe -o"%~dp0%app%"
type nul > %app%\portable_mode_enabled
echo.
echo.
del /s /q %app%.exe
echo.
echo.
echo Portable location: %~dp0%app%
echo.
echo.
timeout /t 5
exit
:link
for %%a in (%*) do (call :trim %%a)
exit /b
:trim
set /a int+=1
set temp=%~1
set link[%int%]=https://www.foobar2000.org%temp:getfile=files%
set name[%int%]=%temp:~9,-4%
echo %int%. !link[%int%]!
exit /b
