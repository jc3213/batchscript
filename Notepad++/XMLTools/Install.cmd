@ECHO OFF
FOR /F "tokens=1,2*" %%I IN ('REG QUERY HKLM\SOFTWARE\Notepad++ /VE') DO (IF "%%I"=="(Default)" SET Folder=%%K\plugins\XMLTools)
FOR /F "tokens=*" %%I IN ('DIR %~DP0XMLTools-*.zip /B /OD') DO (SET Zip=%~DP0%%I)
MD "%Folder%" 2>NUL
%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe -Command "Expand-Archive -Force -Path '%Zip%' -DestinationPath '%Folder%'"
TIMEOUT /T 5
