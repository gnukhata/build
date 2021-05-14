@echo off
start /b C:\gnukhatav7.0\gkcore.bat
@echo off
cd C:\gnukhatav7.0\WPy64-3830\gkwebapp
C:\gnukhatav7.0\WPy64-3830\python-3.8.3.amd64\python.exe setup.py develop
C:\gnukhatav7.0\WPy64-3830\python-3.8.3.amd64\Scripts\pserve.exe production.ini
exit
