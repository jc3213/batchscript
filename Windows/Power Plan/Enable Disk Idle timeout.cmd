@echo off
powercfg /change disk-timeout-ac 20
powercfg /change disk-timeout-dc 20
timeout /t 5
