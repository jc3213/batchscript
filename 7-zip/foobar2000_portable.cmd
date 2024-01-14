@echo off
pushd %~dp0
for /f "tokens=2*" %%a in ('reg query "HKLM\Software\7-Zip" /v "Path"') do (set zip=%%b7z.exe)
for /f "tokens=1-4 delims= " %%a in ('curl https://www.foobar2000.org/download --silent ^| findstr /r /c:"/getfile/foobar2000*"') do (set ver=%%c)
if %Processor_Architecture% equ AMD64 set arc=-x64
if %Processor_Architecture% equ ARM64 set arc=-arm64ec
set app=foobar2000%arc%_%ver%
set exe=%app%.exe
set url=https://www.foobar2000.org/files/%exe%
echo.
echo.
echo Downloading: "%exe%"
curl %url% --location --output %exe% >nul 2>&1
"%zip%" x %exe% -y -x!$PLUGINSDIR -x!$R0 -x!uninstall.exe -o"%app%"
type nul > %app%\portable_mode_enabled
del /s /q %exe% >nul 2>&1
echo Foobar2000 Portable: "%app%"
timeout /t 5
