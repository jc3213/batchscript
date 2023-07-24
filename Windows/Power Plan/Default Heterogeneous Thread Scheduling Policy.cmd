@echo off
powercfg /setacvalueindex scheme_current sub_processor SCHEDPOLICY 5
powercfg /setacvalueindex scheme_current sub_processor SHORTSCHEDPOLICY 5
timeout /t 5
