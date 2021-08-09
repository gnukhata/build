rem ### Script to start Nginx and Gkcore and Gkwebapp servers ###
rem ### This script is run on system startup ###
cd C:\gnukhatav7.0.t\nginx\
start nginx.exe
start /b C:\gnukhatav7.0.t\start_gkcore.bat
start /b C:\gnukhatav7.0.t\start_gkwebapp.bat