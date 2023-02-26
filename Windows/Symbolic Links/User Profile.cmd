@ECHO OFF
:Drive
ECHO ====================================================
ECHO Please enter the disk label for user profile
ECHO ====================================================
SET /P Label=^>
IF NOT DEFINED Label CLS && GOTO :Drive
SET Drive=%Label::=%
:Profile
RD /S /Q "%UserProfile%\Desktop" 2>NUL
RD /S /Q "%UserProfile%\Documents" 2>NUL
RD /S /Q "%UserProfile%\Downloads" 2>NUL
RD /S /Q "%UserProfile%\Music" 2>NUL
RD /S /Q "%UserProfile%\Pictures" 2>NUL
RD /S /Q "%UserProfile%\Saved Games" 2>NUL
RD /S /Q "%UserProfile%\Videos" 2>NUL
MD "%Drive%:\Home\Desktop" 2>NUL
MD "%Drive%:\Home\Documents" 2>NUL
MD "%Drive%:\Home\Downloads" 2>NUL
MD "%Drive%:\Home\Music" 2>NUL
MD "%Drive%:\Home\Pictures" 2>NUL
MD "%Drive%:\Home\Saved Games" 2>NUL
MD "%Drive%:\Home\Videos" 2>NUL
MKLINK /D "%UserProfile%\Desktop" "%Drive%:\Home\Desktop"
MKLINK /D "%UserProfile%\Documents" "%Drive%:\Home\Documents"
MKLINK /D "%UserProfile%\Downloads" "%Drive%:\Home\Downloads"
MKLINK /D "%UserProfile%\Music" "%Drive%:\Home\Music"
MKLINK /D "%UserProfile%\Pictures" "%Drive%:\Home\Pictures"
MKLINK /D "%UserProfile%\Saved Games" "%Drive%:\Home\Saved Games"
MKLINK /D "%UserProfile%\Videos" "%Drive%:\Home\Videos"
TIMEOUT /T 5
