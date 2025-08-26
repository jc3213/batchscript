@echo off
setlocal
title Manga Denoise and Super Sampling (Extreme)
echo ===================================================================
echo Use Real-CUGAN, Real-ESRGAN, and Waifu2x to Denoise and Upscale
echo Use ImageMagick for Evaluation and Super Sampling
echo ===================================================================
set start=%time%
for %%a in (%*) do (call :fixer "%%~a")
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
echo.
echo.
echo Elapsed  : %hour%:%minute%:%second%.%millsec%
endlocal
pause
exit
:fixer
cd /d %1 2>nul
if %errorlevel% equ 0 goto :folder
goto :result
exit /b
:folder
for %%a in (*) do (call :result "%%~a")
exit /b
:result
echo.
echo.
echo Fixing   : "%~dpnx1"
"%~dp0upscaler\realcugan-ncnn-vulkan.exe" -i "%~1" -o "%~dp1temp_cugan_%~n1.png" -m models-se -s 2 -n 1 -t 32 -x >nul 2>nul
"%~dp0upscaler\realesrgan-ncnn-vulkan.exe" -i "%~1" -o "%~dp1temp_esrgan_%~n1.png" -n realesr-animevideov3 -s 2 -t 32 -x >nul 2>nul
"%~dp0upscaler\waifu2x-ncnn-vulkan.exe" -i "%~1" -o "%~dp1temp_waifu2x_%~n1.png" -m models-cunet -s 2 -n 1 -t 32 -x >nul 2>nul
"%~dp0magick\magick.exe" "%~dp1temp_esrgan_%~n1.png" "%~dp1temp_cugan_%~n1.png" "%~dp1temp_waifu2x_%~n1.png" "%~dp1temp_esrgan_%~n1.png" -evaluate-sequence mean "%~dp1temp_eval_%~n1.png"
"%~dp0magick\magick.exe" "%~dp1temp_eval_%~n1.png" -resize x1600 -quality 90 "%~dp1result_%~n1.jpg" >nul 2>nul
echo Result   : "%~dp1result_%~n1.jpg"
exit /b
