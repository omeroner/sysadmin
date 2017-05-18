#!/bin/bash
### Set initial time of file
### omeroner.com

LTIME=`stat -c %Z /var/log/lsyncd/lsyncd.log`

while true
do
   ATIME=`stat -c %Z /var/log/lsyncd/lsyncd.log`

   if [[ "$ATIME" != "$LTIME" ]]
   then
        for i in $(diff  /tmp/lsyncd.log.tmp /var/log/lsyncd/lsyncd.log | awk '{print $2}' | rev | cut -d'/' -f 1 | rev)
          do
            echo $i changed
            del=$(ssh username@ipaddress show cache object | grep "$i")
            locatorid=$(echo $del | awk '{print $1}')
            username@ipaddress flush cache object -locator $locatorid
            echo $i deleted
          done
       LTIME=$ATIME
       cat /var/log/lsyncd/lsyncd.log > /tmp/lsyncd.log.tmp
   fi
   sleep 5
done
