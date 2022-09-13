#!/bin/bash

#gkcore
cd /gnukhata/gkcore
echo "pulling latest gkcore changes ..."
git pull
echo "checking database status"
python3 initdb.py

echo "checking pip dependencies"
pip3 install -r requirements.txt
python3 setup.py develop
pserve production.ini

#gkwebapp
cd /gnukhata/gkwebapp
echo "pulling latest gkwebapp changes ..."
git pull
echo "checking pip dependencies"
pip3 install -r requirements.txt
python3 setup.py develop
pserve production.ini

# this is causing CORS issues in some API's
# Disabling until furthur inspection.
# supervisor
# echo "starting supervisor"
# cd /gnukhata
# supervisord -c supervisord.conf
tail -f /dev/null
