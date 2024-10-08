@echo off
pushd %~dp0
for /f "tokens=3" %%a in ('curl https://www.foobar2000.org/download --silent ^| findstr "foobar2000-arm64ec_v"') do (set ver=%%a)
for /f "tokens=2*" %%a in ('reg query "HKLM\Software\7-Zip" /v "Path"') do (set zip=%%b7z.exe)
if %processor_architecture% equ AMD64 set arc=-x64
if %processor_architecture% equ ARM64 set arc=-arm64ec
set app=foobar2000%arc%_%ver%
set exe=%app%.exe
set url=https://www.foobar2000.org/files/%exe%
echo Downloading : "%exe%"
curl %url% --location --output %exe% >nul 2>&1
"%zip%" x %exe% -y -x!$PLUGINSDIR -x!$R0 -x!uninstall.exe -o"%app%" >nul 2>&1
type nul > %app%\portable_mode_enabled
del /s /q %exe% >nul 2>&1
echo Foobar2000  : "%app%"
start "" "%app%"
timeout /t 5
