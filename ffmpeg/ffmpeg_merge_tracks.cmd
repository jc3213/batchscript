@ECHO OFF
:File1
IF NOT EXIST "%1" (
    GOTO :End
)
SET input=-i "%1"
SET num=1
:File2
IF NOT EXIST "%2" (
    GOTO :Proc
)
SET input=%input% -i "%2"
SET num=2
:File3
IF NOT EXIST "%3" (
    GOTO :Proc
)
SET input=%input% -i "%3"
SET num=3
:File4
IF NOT EXIST "%4" (
    GOTO :Proc
)
SET input=%input% -i "%4"
SET num=4
:File5
IF NOT EXIST "%5" (
    GOTO :Proc
)
SET input=%input% -i "%5"
SET num=5
:File6
IF NOT EXIST "%6" (
    GOTO :Proc
)
SET input=%input% -i "%6"
SET num=6
:File7
IF NOT EXIST "%7" (
    GOTO :Proc
)
SET input=%input% -i "%7"
SET num=7
:File8
IF NOT EXIST "%8" (
    GOTO :Proc
)
SET input=%input% -i "%8"
SET num=8
:File9
IF NOT EXIST "%9" (
    GOTO :Proc
)
SET input=%input% -i "%9"
SET num=9
:Proc
"%~DP0bin\ffmpeg.exe" %input% -filter_complex "amerge=inputs=%num%" merged_audio_track%~x1
:End
EXIT
