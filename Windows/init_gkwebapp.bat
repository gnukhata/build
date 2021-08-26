rem ### Script to install the dependencies for gkwebapp ###
@echo off
cd C:\gnukhatav7.0.t\gkwebapp
C:\gnukhatav7.0.t\python\python.exe setup.py develop --always-unzip --allow-hosts=None --find-links=C:\gnukhatav7.0.t\pip_dependencies
exit
