@ECHO OFF
REG DELETE "HKCR\*\shell\runas" /F
REG DELETE "HKCR\Directory\shell\runas" /F
TIMEOUT /T 5