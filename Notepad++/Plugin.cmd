@ECHO OFF
FOR /F "tokens=1,2*" %%I IN ('REG QUERY HKLM\SOFTWARE\Notepad++ /VE') DO (IF "%%I"=="(Default)" SET Folder=%%K\plugins)
FOR /F "tokens=*" %%I IN ('DIR %~DP0*.zip /B /OD') DO (CALL :Install "%~DP0%%I")
GOTO :Exit
:Install
SET Name=%~N1
FOR /F "tokens=1 delims=-_." %%I IN ("%Name%") DO (SET Plugin=%Folder%\%%I)
MD "%Plugin%" 2>NUL
%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe -Command "Expand-Archive -Force -Path '%~1' -DestinationPath '%Plugin%'"
EXIT /B
:Exit
TIMEOUT /T 5
