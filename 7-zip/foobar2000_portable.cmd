@echo off
pushd %~dp0
for /f "tokens=2*" %%a in ('reg query "HKLM\Software\7-Zip" /v "Path"') do (set zip=%%b7z.exe)
for /f "tokens=4 delims= " %%a in ('curl https://www.foobar2000.org/download --silent ^| findstr /r /c:"foobar2000 v.* release notes"') do (set ver=%%a)
if %Processor_Architecture% equ AMD64 set arc=-x64
if %Processor_Architecture% equ ARM64 set arc=-arm64ec
set app=foobar2000%arc%_%ver%
set exe=%app%.exe
set url=https://www.foobar2000.org/files/%exe%
curl %url% --location --output %exe% -x 127.0.0.1:7890
echo.
echo.
echo Portable folder - %app%
"%zip%" x %exe% -y -x!$PLUGINSDIR -x!$R0 -x!uninstall.exe -o"%app%"
type nul > %app%\portable_mode_enabled
echo.
echo.
del /s /q %exe%
echo.
echo.
echo Done!
timeout /t 5
