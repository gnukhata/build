#!/bin/bash

#gkcore
cd /gnukhata/gkcore
pserve production.ini

tail -f /dev/null
