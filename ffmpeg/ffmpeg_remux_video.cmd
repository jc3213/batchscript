@ECHO OFF
:File1
IF NOT EXIST "%1" (
    GOTO :End
)
SET input=-i "%1"
:File2
IF NOT EXIST "%2" (
    GOTO :Proc
)
SET input=%input% -i "%2"
:File3
IF NOT EXIST "%3" (
    GOTO :Proc
)
SET input=%input% -i "%3"
:File4
IF NOT EXIST "%4" (
    GOTO :Proc
)
SET input=%input% -i "%4"
:File5
IF NOT EXIST "%5" (
    GOTO :Proc
)
SET input=%input% -i "%5"
:File6
IF NOT EXIST "%6" (
    GOTO :Proc
)
SET input=%input% -i "%6"
:File7
IF NOT EXIST "%7" (
    GOTO :Proc
)
SET input=%input% -i "%7"
:File8
IF NOT EXIST "%8" (
    GOTO :Proc
)
SET input=%input% -i "%8"
:File9
IF NOT EXIST "%9" (
    GOTO :Proc
)
SET input=%input% -i "%9"
:Proc
"%~DP0bin\ffmpeg.exe" %input% -c:v copy -c:a copy remuxed_%~n1.mkv -threads 128
:End
EXIT
