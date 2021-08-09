rem ### Script to stop all the processes spawned by GnuKhata and unregister the pgsql service registered during installation ###
rem ### This script runs before GNUKhata is uninstalled  ###
start /b C:\gnukhatav7.0.t\stop_gk_process.bat
sc delete gk_postgresql