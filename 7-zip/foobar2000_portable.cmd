@echo off
pushd %~dp0
for /f "tokens=2*" %%a in ('reg query "HKLM\Software\7-Zip" /v "Path"') do (set zip=%%b7z.exe)
for /f "tokens=3 delims= " %%a in ('curl https://www.foobar2000.org/download --silent ^| find "Download foobar2000 v"') do (set ver=%%a)
if %Processor_Architecture% equ AMD64 set arc=-x64
if %Processor_Architecture% equ ARM64 set arc=-arm64ec
set app=foobar2000%arc%_%ver%.exe
set url=https://www.foobar2000.org/files/%app%
curl %url% --location --output %app%.exe
echo.
echo.
echo Make portable - %~dp0%app%
"%zip%" x "%~dp0%app%.exe" -y -x!$PLUGINSDIR -x!$R0 -x!uninstall.exe -o"%~dp0%app%"
type nul > %app%\portable_mode_enabled
echo.
echo.
del /s /q %app%.exe
echo.
echo.
timeout /t 5
exit
