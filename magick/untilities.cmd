@ECHO OFF
TITLE ImageMagick Utilities
IF NOT EXIST %1 GOTO :Exit
SET Name=%~N1
ECHO ============================================================
CD /D %1 2>NUL
IF %ErrorLevel% EQU 0 (
    ECHO 1^) Crop Image Area
    ECHO 2^) Cut Image Border
    ECHO 3^) Convert to JPG
    ECHO 4^) Compress as ZIP
) ELSE (
    ECHO 1^) Repack to new ZIP
    SET File=%1
)
ECHO ============================================================
:What
SET /P ACT=^> 
ECHO.
IF NOT DEFINED File (
    IF %ACT% EQU 1 GOTO :Crop
    IF %ACT% EQU 2 GOTO :Shave
    IF %ACT% EQU 3 GOTO :JPG
    IF %ACT% EQU 4 GOTO :ZIP
) ELSE (
    IF %ACT% EQU 1 GOTO :Repack
)
GOTO :What
:Crop
CALL :Front
SET Folder=%~DP1cutted_%Name%
MD "%Folder%" 2>NUL
FOR %%I IN (*) DO ("%~DP0bin\magick.exe" convert %%I -crop %Area% "%Folder%\%%I")
GOTO :End
:Shave
CALL :Front
SET Folder=%~DP1cutted_%Name%
MD "%Folder%" 2>NUL
FOR %%I IN (*) DO ("%~DP0bin\magick.exe" convert %%I -shave %Area% "%Folder%\%%I")
GOTO :End
:JPG
ECHO.
ECHO ============================================================
ECHO ImageMagick is converting images...
ECHO ============================================================
SET Folder=%~DP1conv_%~N1
MD "%Folder%" 2>NUL
FOR %%I IN (*) DO ("%~DP0bin\magick.exe" %%I "%Folder%\%%~NI.jpg")
GOTO :End
:Repack
ECHO.
ECHO ============================================================
ECHO Repacking to new Zip...
ECHO ============================================================
SET Folder=%~N1
ECHO a|"%~DP0bin\7za.exe" x %1 -o"%Folder%"
CD %Folder% 2>NUL
IF %ErrorLevel% NEQ 0 GOTO :Exit
"%~DP0bin\7za.exe" a "%~DPN1.zip" "*"
CD..
RD /S /Q "%Folder%"
GOTO :Exit
:End
ECHO.
ECHO.
ECHO ============================================================
ECHO Compress as Zip file? (y)
ECHO ============================================================
SET /P Zip=^> 
IF %Zip% NEQ y GOTO :Exit
:ZIP
IF NOT DEFINED Folder SET Folder=%~1
"%~DP0bin\7za.exe" a "%~DPN1.zip" "%Folder%\*"
ECHO.
ECHO.
ECHO ============================================================
ECHO Remove original files? (y)
ECHO ============================================================
SET /P Cfm=^> 
IF %Cfm% NEQ y GOTO :Exit
CD..
RD /S /Q %1 2>NUL
RD /S /Q "%Folder%" 2>NUL
:Exit
TIMEOUT -T 5
EXIT
:Front
ECHO.
ECHO ============================================================
ECHO https://imagemagick.org/script/command-line-processing.php#geometry
ECHO Sample: 300x100 (width x height)
ECHO Cut left and right: 300px(width), cut top and bottom: 100px(height)
ECHO Sample: 300x100+20+30 (width x height + left + top)
ECHO Crop image area start from: left 20px to 320px, top: 30px to 130px
ECHO ============================================================
SET /P Area=^> 
IF NOT DEFINED Area GOTO :Front
ECHO.
ECHO.
ECHO ============================================================
ECHO ImageMagick is cutting images...
ECHO ============================================================
EXIT /B
