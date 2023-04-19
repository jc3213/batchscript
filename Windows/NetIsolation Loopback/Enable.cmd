@echo off
for /d %%a in (%LocalAppData%\Packages\*) do (CheckNetIsolation LoopbackExempt -a -n=%%a)
timeout /t 5
