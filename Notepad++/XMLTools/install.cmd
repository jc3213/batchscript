@ECHO OFF
FOR /F "tokens=1,2*" %%I IN ('REG QUERY HKLM\SOFTWARE\Notepad++ /VE') DO (IF "%%I"=="(Default)" SET Folder=%%K\plugins\XMLTools)
FOR /F "TOKENS=*" %%I IN ('DIR %~DP0*.zip /B /OD') DO (SET Zip=%~DP0%%I)
MD "%Folder%" 2>NUL
POWERSHELL -Command "Expand-Archive -Force '%Zip%' '%Folder%'"
TIMEOUT -T 5
