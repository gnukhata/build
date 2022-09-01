#!/bin/bash
service nginx start
service postgresql start
su -c "supervisord" gkadmin
tail -f /dev/null
