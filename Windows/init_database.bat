rem ### Script to initialize DB, register the postgres windows service and create the DB to be used by GNUKhata ###
@echo off
cd C:\gnukhatav7.0.t\pgsql\bin
initdb -D C:\gnukhatav7.0.t\pgsql\pgdata -U postgres -E UTF8 -A md5 --pwfile=C:\gnukhatav7.0.t\pgsql\.pg_pwd.txt

rem The postgres server is started manually after installation, as the service registeres only starts after system restart 
pg_ctl -D "C:\gnukhatav7.0.t\pgsql\pgdata" -l logfile start 

psql -c "CREATE DATABASE gkdata" "user=postgres dbname=postgres password=gkadmin"
pg_ctl register -N "gk_postgresql" -U "NT AUTHORITY\NetworkService" -D "C:\gnukhatav7.0.t\pgsql\pgdata" -w
exit