@ECHO OFF
SC STOP "SysMain"
SC CONFIG "SysMain" START=DISABLED
DEL /F /S /Q %SystemRoot%\Prefetch\*.*
TIMEOUT /T 5
