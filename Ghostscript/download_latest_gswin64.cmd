@echo off
setlocal
pushd %~dp0
echo Get latest Ghostscript version . . .
for /f "tokens=7 delims=/" %%a in ('curl -s -D - https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/latest ^| findstr /i "location:"') do (set tag=%%a)
echo.
echo The latest release tag is "%tag%"
echo.
set file=%tag%w64.exe
if exist "%file%" goto :extract
set "url=https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/%tag%/%file%"
echo Start downloading "%file%" . . .
echo.
curl -L -o "%file%" "%url%"
echo.
echo Download completed . . .
echo.
:extract
for /f "tokens=2*" %%a in ('reg query "HKLM\Software\7-Zip" /v "Path"') do (set zip=%%b7z.exe)
if not exist "%zip%" goto :complete
echo Extracting "gswin64c.exe" and "gsdll64.dll" . . .
"%zip%" e "%file%" "bin\gswin64c.exe" "bin\gsdll64.dll" -y >nul 2>nul
echo.
echo "gswin64c.exe" and "gsdll64.dll" has been extracted
:complete
endlocal
timeout /t 5
