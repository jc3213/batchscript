@ECHO OFF
:Drive
ECHO ====================================================
ECHO Please enter the ramdisk label for temporary files
ECHO ====================================================
SET /P Label=^>
IF NOT DEFINED Label CLS && GOTO :Drive
SET Drive=%Label::=%
:Temp
RD /S /Q "%LocalAppData%\Temp"
RD /S /Q "%SystemRoot%\Temp"
MD %Drive%:\Temp 2>NUL
MKLINK /D "%LocalAppData%\Temp" "%Drive%:\Temp"
MKLINK /D "%SystemRoot%\Temp" "%Drive%:\Temp"
TIMEOUT /T 5
