@echo off
cd "c:\Program Files\PostgreSQL\9.6\bin"
psql -c "CREATE DATABASE gkdata" "user=postgres dbname=postgres password=gkadmin"
cd C:\gnukhatav7.0\WPy64-3830\gkcore
C:\gnukhatav7.0\WPy64-3830\python-3.8.3.amd64\python.exe initdb.py
exit