#!/bin/bash

cd /gnukhata/gkcore
echo "pulling latest gkcore changes ..."
git pull
echo "checking database status"
python3 initdb.py

echo "pulling latest gkwebapp changes ..."
cd /gnukhata/gkwebapp
git pull

echo "starting supervisor"
cd /gnukhata
supervisord -c supervisord.conf
tail -f /dev/null
