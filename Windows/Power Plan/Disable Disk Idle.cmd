@echo off
powercfg /change disk-timeout-ac 0
powercfg /change disk-timeout-dc 0
timeout /t 5
