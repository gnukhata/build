rem ### Script to stop all the processes spawned by GNUKhata ###
taskkill /IM "pserve.exe" /F
taskkill /IM "python.exe" /F
taskkill /IM "nginx.exe" /F
taskkill /IM "postgres.exe" /F