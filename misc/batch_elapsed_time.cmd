@echo off
setlocal enabledelayedexpansion
set start=%time%

rem Your codes here...

rem End of codes

set finish=%time%
set /a hour=%finish:~0,2%-%start:~0,2%
set /a minute=%finish:~3,2%-%start:~3,2%
set /a second=%finish:~6,2%-%start:~6,2%
set /a millisecond=%finish:~9,2%-%start:~9,2%
if %millisecond% lss 0 (
    set /a millisecond+=100
    set /a second-=1
)
if %second% lss 0 (
    set /a second+=60
    set /a minute-=1
)
if %minute% lss 0 (
    set /a minute+=60
    set /a hour-=1
)
if %hour% lss 0 (
    set /a hour+=24
)
if %hour% neq 0 (
    echo %hour%:%minute%:%second%.%millisecond%
) else if %minute% neq 0 (
    echo %minute%:%second%.%millisecond%
) else (
    echo %second%.%millisecond%
)
endlocal
pause
