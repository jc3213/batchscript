@echo off
for /d %%a IN (%LocalAppData%\Packages\*) DO (CheckNetIsolation LoopbackExempt -a -n=%%a)
timeout /t 5
