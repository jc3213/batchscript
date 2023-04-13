@ECHO OFF
TITLE ImageMagick Utilities
SET Magick=%~DP0bin\magick.exe
:Option
ECHO ============================================================
ECHO 1. Crop with area
ECHO 2. Cut off border
ECHO 3. Convert format
ECHO ============================================================
SET /P Act=^> 
IF %Act% EQU 1 GOTO :Crop
IF %Act% EQU 2 GOTO :Shave
IF %Act% EQU 3 GOTO :Conv
CLS && GOTO :Option
:Crop
CALL :Area
FOR %%I IN (%*) DO (CALL :Process %%I crop)
GOTO :Exit
:Shave
CALL :Area
FOR %%I IN (%*) DO (CALL :Process %%I shave)
GOTO :Exit
:Conv
CALL :Format
FOR %%I IN (%*) DO (CALL :Convert %%I)
GOTO :Exit
:Area
ECHO.
ECHO.
ECHO ============================================================
ECHO https://imagemagick.org/script/command-line-processing.php#geometry
ECHO Sample: 300x100 (width x height)
ECHO Cut left and right: 300px(width), cut top and bottom: 100px(height)
ECHO Sample: 300x100+20+30 (width x height + left + top)
ECHO Crop image area start from: left 20px to 320px, top: 30px to 130px
ECHO ============================================================
SET /P Area=^> 
IF NOT DEFINED Area GOTO :Area
ECHO.
ECHO.
ECHO ============================================================
ECHO ImageMagick is processing images...
ECHO ============================================================
ECHO.
EXIT /B
:Process
CD /D %1 2>NUL
IF %ErrorLevel% EQU 0 (
    MD "%~DP1cutted_%~NX1" 2>NUL
    FOR %%I IN (*) DO ("%Magick%" convert "%%I" -%2 %Area% "%~DP1cutted_%~NX1\%%I")
    CD..
) ELSE (
    "%Magick%" convert %1 -%2 %Area% "%~DP1cutted_%~NX1"
)
EXIT /B
:Format
ECHO.
ECHO.
ECHO ============================================================
ECHO 1. jpg
ECHO 2. png
ECHO 3. avif
ECHO ============================================================
SET /P FM=^> 
IF %FM% EQU 1 SET Format=jpg
IF %FM% EQU 2 SET Format=png
IF %FM% EQU 3 SET Format=avif
IF NOT DEFINED Format GOTO :Format
ECHO.
EXIT /B
:Convert
CD /D %1 2>NUL
IF %ErrorLevel% EQU 0 (
    MD "%~DP1conv_%~NX1" 2>NUL
    FOR %%I IN (*) DO ("%Magick%" "%%I" "%~DP1conv_%~NX1\%%~NI.%Format%")
    CD..
) ELSE (
    "%Magick%" %1 "%~DP1conv_%~N1.%Format%"
)
EXIT /B
:Exit
TIMEOUT -T 5
