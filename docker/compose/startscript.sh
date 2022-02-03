#!/bin/bash

# # delete virtualenv & recreate a fresh one
# rm -rf gkenv
# python3 -m venv gkenv
# . gkenv/bin/activate

#gkcore
cd /gnukhata/gkcore
echo "pulling latest gkcore changes ..."
git pull
echo "checking database status"
python3 initdb.py

echo "checking pip dependencies"
pip3 install -r requirements.txt
python3 setup.py develop

#gkwebapp
cd /gnukhata/gkwebapp
echo "pulling latest gkwebapp changes ..."
git pull

echo "checking pip dependencies"
pip3 install -r requirements.txt
python3 setup.py develop

# supervisor
echo "starting supervisor"
cd /gnukhata
supervisord -c supervisord.conf
tail -f /dev/null
