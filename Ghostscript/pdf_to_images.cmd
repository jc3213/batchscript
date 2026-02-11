@echo off
setlocal
set start=%time%
for %%a in (%*) do (call :pdf2img %%a)
echo.
echo.
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
:pdf2img
if "%~x1" neq ".pdf" exit /b
echo Start converting "%~1" to images
echo.
echo.
set folder=%~dpn1\images
if not exist "%folder%" mkdir "%folder%"
"%~dp0Ghostscript\gswin64c.exe" ^
    -dNOPAUSE -dBATCH -dSAFER ^
    -sDEVICE=png16m ^
    -r300 ^
    -sOutputFile="%~dpn1\images\page_%%03d.png" ^
    "%~1"
echo.
echo.
echo Conversion of "%~1" has been completed!
