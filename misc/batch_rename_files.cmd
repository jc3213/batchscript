@ECHO OFF
IF "%~N1"=="" EXIT
SETLOCAL EnableDelayedExpansion
PUSHD %~DPN1
FOR /F "TOKENS=*" %%I IN (
    'DIR /B /A-D'
) DO (
    FOR /F "TOKENS=2 DELIMS=-_.()" %%J IN (
        "%%I"
    ) DO (
        CALL :Filename "%%I" "%%J"
    )
)
PAUSE
EXIT
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
    SET Prefix=%2
)
ECHO %~1 %~2 %Prefix%%~X1
REN %1 %Prefix%%~X1
EXIT /B
