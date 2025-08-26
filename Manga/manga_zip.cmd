@echo off
setlocal enabledelayedexpansion
set start=%time%
for /f "tokens=2*" %%a in ('reg query "HKLM\Software\7-Zip" /v "Path"') do (set zip=%%b7z.exe)
for %%a in (%*) do (call :main %%a)
set finish=%time%
set /a stsec=%start:~0,2%*360000+%start:~3,2%*6000+%start:~6,2%*100+%start:~9,2%
set /a finsec=%finish:~0,2%*360000+%finish:~3,2%*6000+%finish:~6,2%*100+%finish:~9,2%
if %finsec% lss %stsec% set /a finsec+=8640000
set /a elapsed=%finsec%-%stsec%
set /a hour=elapsed/360000
set /a minute=(elapsed%%360000)/6000
set /a second=(elapsed%%6000)/100
set /a millsec=elapsed%%100
if %hour% lss 10 set hour=0%hour%
if %minute% lss 10 set minute=0%minute%
if %second% lss 10 set second=0%second%
if %millsec% lss 10 set millsec=0%millsec%
echo Elapsed  : %hour%:%minute%:%second%.%millsec%
endlocal
pause
exit
:main
echo 7-Zip is processing "%~nx1"
cd /d %1 2>nul
if %errorlevel% equ 0 goto :newzip
:repack
"%zip%" x %1 -o"%~dpn1" -aoa >nul
"%zip%" a "%~dpn1.zip" "%~dpn1\*" >nul
echo.
if defined keep exit /b
rd /s /q "%~dpn1"
if /i %~x1 neq .zip del %1 /s /q
exit /b
:newzip
"%zip%" a "%~dpnx1.zip" "*" >nul
echo.
if defined keep exit /b
cd..
rd /s /q "%~1"
exit /b
