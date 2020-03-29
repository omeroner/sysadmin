#!/bin/bash

url="www.omeroner.com"
status_code=$(curl -o /dev/null --silent --head --write-out '%{http_code}\n' $url)
date=`date`

if [ $status_code -ne "200" ]
then
 echo "status check failed at $date" >> /var/log/status_check.log
#You can add further actions here
fi
