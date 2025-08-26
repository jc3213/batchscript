@echo off
setlocal
set start=%time%
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
set name=%~n1
set tem1=%name:*]=%
for /f "tokens=1 delims= " %%a in ("%tem1%") do (set out=%%a)
md "%~dp1%out%" >nul 2>nul
move %1 "%~dp1%out%"
exit /b
