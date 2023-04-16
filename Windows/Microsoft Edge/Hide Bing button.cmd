@ECHO OFF
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Edge" /V "HubsSidebarEnabled"  /T "REG_DWORD" /D "0x00000000" /F
TIMEOUT /T 5
