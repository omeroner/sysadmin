#!/bin/bash

SITE=$(ls -l /etc/letsencrypt/live | egrep  '^d'| awk '{print $9 }')

for SSL in $SITE
do
cat /etc/letsencrypt/live/$SSL/fullchain.pem /etc/letsencrypt/live/$SSL/privkey.pem > /etc/haproxy/certs/$SSL.pem
done
#service haproxy restart
