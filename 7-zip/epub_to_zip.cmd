@echo off
setlocal
pushd %~dp0
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
cd /d %1 2>nul
if %errorlevel% equ 0 goto :folder
goto :epub2zip
:folder
for %%a in (*) do (call :epub2zip "%%~a")
exit /b
:epub2zip
echo %~n1
if "%~x1" neq ".epub" goto :eof
echo 7-Zip is processing "%~s1"
"%zip%" x %1 -o"%~dpn1" -aoa >nul
"%zip%" a "%~dpn1.zip" "%~dpn1\OEBPS\*.jpg" >nul
rd /s /q "%~dpn1"