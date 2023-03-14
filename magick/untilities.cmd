@ECHO OFF
TITLE ImageMagick Utilities
SET Zip=%~DP0bin\7za.exe
CD /D %1 2>NUL
IF %ErrorLevel% EQU 0 GOTO :DirOpt
IF %~X1 EQU .zip GOTO :ZipOpt
GOTO :Exit
:DirOpt
ECHO ============================================================
ECHO 1. Crop Image Area
ECHO 2. Cut Image Border
ECHO 3. Convert to JPG
ECHO 4. Compress as ZIP
ECHO ============================================================
:DirAct
SET /P Act=^> 
IF %Act% EQU 1 GOTO :Crop
IF %Act% EQU 2 GOTO :Shave
IF %Act% EQU 3 GOTO :JPG
IF %Act% EQU 4 GOTO :ComZip
GOTO :DirAct
:ZipOpt
ECHO ============================================================
ECHO 1. Repack to new ZIP
ECHO ============================================================
:ZipAct
SET /P Act=^> 
IF %Act% EQU 1 GOTO :Repack
GOTO :ZipAct
:Crop
CALL :Area
SET Folder=%~DP1cutted_%~NX1
MD "%Folder%" 2>NUL
FOR %%I IN (*) DO ("%~DP0bin\magick.exe" convert %%I -crop %Area% "%Folder%\%%I")
GOTO :Compress
:Shave
CALL :Area
SET Folder=%~DP1cutted_%~NX1
MD "%Folder%" 2>NUL
FOR %%I IN (*) DO ("%~DP0bin\magick.exe" convert %%I -shave %Area% "%Folder%\%%I")
GOTO :Compress
:JPG
ECHO.
ECHO ============================================================
ECHO ImageMagick is converting images...
ECHO ============================================================
SET Folder=%~DP1conv_%~NX1
MD "%Folder%" 2>NUL
FOR %%I IN (*) DO ("%~DP0bin\magick.exe" %%I "%Folder%\%%~NI.jpg")
GOTO :Compress
:Compress
ECHO.
ECHO.
ECHO ============================================================
ECHO Compress as Zip file? (y)
ECHO ============================================================
SET /P Com=^> 
IF %Com% NEQ y GOTO :Remove
:ComZip
IF NOT DEFINED Folder SET Folder=%~1
"%Zip%" a "%~DPNX1.zip" "%Folder%\*"
:Remove
ECHO.
ECHO.
ECHO ============================================================
ECHO Remove original files? (y)
ECHO ============================================================
SET /P Del=^> 
IF %Del% NEQ y GOTO :Exit
CD..
RD /S /Q %1 2>NUL
RD /S /Q "%Folder%" 2>NUL
GOTO :Exit
:Repack
ECHO.
ECHO ============================================================
ECHO Repacking to new Zip...
ECHO ============================================================
SET Folder=%~N1
ECHO a|"%Zip%" x %1 -o"%Folder%"
CD %Folder% 2>NUL
IF %ErrorLevel% NEQ 0 GOTO :Exit
"%Zip%" a "%~DPN1.zip" "*"
CD..
RD /S /Q "%Folder%"
GOTO :Exit
:Exit
TIMEOUT -T 5
EXIT
:Area
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
ECHO ImageMagick is cutting images...
ECHO ============================================================
EXIT /B
