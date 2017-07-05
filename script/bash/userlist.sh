#!/bin/bash

host1=$(hostname)
host2=$(hostname -i)

userlist=$(cat /etc/passwd | awk -F':' '$3>=500 &&$3<=6000{ print $1}')
echo $host1-$host2 users list: $userlist
