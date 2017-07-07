#!/bin/bash

server='
10.10.11.10
10.10.11.11
10.10.11.12
10.10.11.13
'



for host in $server
do
echo $host users list:
#ssh root@$host  cat /etc/passwd | awk -F':' '$3>=500 &&$3<=60000{ print $1}'
ssh root@$host  cat /etc/passwd | awk -F: '/\/home/ {printf "%s:%s\n",$1,$3}'
echo -------------------------
done

