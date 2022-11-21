@ECHO OFF
TITLE ImageMagick Utilities
IF NOT EXIST %1 GOTO :Exit
SET Name=%~N1
ECHO ============================================================
CD /D %1 2>NUL
IF %ErrorLevel% EQU 0 (
    ECHO 1^) Cut Image Border
    ECHO 2^) Convert to JPG
    ECHO 3^) Compress as ZIP
) ELSE (
    ECHO 1^) Repack to new ZIP
    SET File=%1
)
ECHO ============================================================
:What
SET /P ACT=^> 
ECHO.
IF NOT DEFINED File (
    IF %ACT% EQU 1 GOTO :Cut
    IF %ACT% EQU 2 GOTO :JPG
    IF %ACT% EQU 3 GOTO :ZIP
) ELSE (
    IF %ACT% EQU 1 GOTO :Repack
)
GOTO :What
:Cut
ECHO.
ECHO ============================================================
ECHO https://imagemagick.org/script/command-line-processing.php#geometry
ECHO Sample: 300x100 (width x height)
ECHO Cut left and right: 300px(width), cut top and bottom: 100px(height)
ECHO ============================================================
SET /P Opt=^> 
IF NOT DEFINED Opt GOTO :Cut
ECHO.
ECHO ============================================================
ECHO ImageMagick is cutting images...
ECHO ============================================================
SET Folder=%~DP1cutted_%Name%
MD "%Folder%" 2>NUL
FOR %%I IN (*) DO ("%~DP0bin\magick.exe" convert %%I -shave %Opt% "%Folder%\%%I")
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
ECHO a|"%~DP0bin\7za.exe" x "%~DPN1.zip" -o"%Folder%"
CD %Folder%
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
TIMEOUT -T 5
:Exit
EXIT
