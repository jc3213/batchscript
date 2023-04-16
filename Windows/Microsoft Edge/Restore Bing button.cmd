@ECHO OFF
REG DELETE "HKLM\SOFTWARE\Policies\Microsoft\Edge" /V "HubsSidebarEnabled" /F
TIMEOUT /T 5
