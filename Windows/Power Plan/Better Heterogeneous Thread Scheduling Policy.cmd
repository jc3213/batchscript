@echo off
powercfg /setacvalueindex scheme_current sub_processor SCHEDPOLICY 2
powercfg /setacvalueindex scheme_current sub_processor SHORTSCHEDPOLICY 2
timeout /t 5
