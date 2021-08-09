rem ### Script to install the dependencies for gkcore and initialize the DB ###
@echo off
cd C:\gnukhatav7.0.t\gkcore
C:\gnukhatav7.0.t\python\python.exe setup.py develop
C:\gnukhatav7.0.t\python\python.exe initdb.py
exit