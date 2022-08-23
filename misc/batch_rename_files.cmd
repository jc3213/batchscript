@ECHO OFF
IF NOT EXIST %1 EXIT
CD /D %1
SETLOCAL EnableDelayedExpansion
SET Seek=1
:SeekFiles
IF "%Index%"=="" SET Index=1-9
FOR /F "TOKENS=*" %%A IN (
    'DIR /B /A-D'
) DO (
    FOR /F "TOKENS=%Index% DELIMS=-_.()" %%B IN (
        "%%A"
    ) DO (
        IF %Seek% EQU 1 (
            ECHO Option		  		%%A
            ECHO ===========================================================
            CALL :ListIndex %%B %%C %%D %%E %%F %%G %%H %%I %%J && GOTO :EOF
        ) ELSE IF %Seek% GTR 1 (
            CALL :Filename "%%A" "%%B"
        )
    )
)
TIMEOUT /T 5
EXIT
:ListIndex
IF "%1"=="" GOTO :SeekIndex
ECHO %1| FINDSTR /R /C:"^[0-9][0-9]*$" > NUL && SET Symbol=** || SET Symbol=
ECHO %Seek%		^>^>		%~1	  %Symbol%
SET /A Seek=%Seek%+1
FOR /F "TOKENS=1,* DELIMS= " %%A IN ("%*") DO (CALL :ListIndex %%B)
:SeekIndex
SET /P Index=Which one?  
IF %Index% LSS 1 GOTO :SeekIndex
IF %Index% GEQ %Seek% GOTO :SeekIndex 
GOTO :SeekFiles
:Filename
SET String=#%~2
SET Length=0
FOR %%K IN (
    4096 2048 1024 512 256 128 64 32 16 8 4 2 1
) DO (
    IF "!String:~%%K,1!" NEQ "" (
        SET /A Length+=%%K
        SET String=!String:~%%K!
    )
)
IF %Length% EQU 1 (
    SET Prefix=000%~2
) ELSE IF %Length% EQU 2 (
    SET Prefix=00%~2
) ELSE IF %Length% EQU 3 (
    SET Prefix=0%~2
) ELSE (
    SET Prefix=%~2
)
ECHO %~1        %~2        %Prefix%%~X1
REN %1 %Prefix%%~X1
EXIT /B
