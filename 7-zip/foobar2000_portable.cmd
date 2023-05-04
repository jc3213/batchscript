@echo off
pushd %~dp0
for /f "tokens=2*" %%a in ('reg query "HKLM\Software\7-Zip" /v "Path"') do (set zip=%%b7z.exe)
for /f "tokens=3 delims= " %%a in ('curl https://www.foobar2000.org/download --silent ^| find "Download foobar2000 v"') do (set ver=%%a)
if %Processor_Architecture% equ AMD64 set arc=-x64
if %Processor_Architecture% equ ARM64 set arc=-arm64ec
set app=foobar2000%arc%_%ver%.exe
set dir=%~dp0foobar2000%arc%_%ver%
set url=https://www.foobar2000.org/files/%app%
curl %url% --location --output %app%
echo.
echo.
echo Portable folder - %dir%
"%zip%" x %app% -y -x!$PLUGINSDIR -x!$R0 -x!uninstall.exe -o"%dir%"
type nul > %app%\portable_mode_enabled
echo.
echo.
del /s /q %app%.exe
echo.
echo.
echo Done!
timeout /t 5
