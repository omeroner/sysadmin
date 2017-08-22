#!/bin/bash
### Set initial time of file
### omeroner.com
PURGE_URL="http://ssc.rocketcdn.com/api/purge?apikey=915fac******************dac779&path"
LTIME=`stat -c %Z /var/log/lsyncd/lsyncd.log`

while true
do
   ATIME=`stat -c %Z /var/log/lsyncd/lsyncd.log`

   if [[ "$ATIME" != "$LTIME" ]]
   then
        for i in $(diff  /tmp/lsyncd.log.tmp /var/log/lsyncd/lsyncd.log | awk '{print $2}' | grep ^/ | egrep ".jpg|.html")
          do
            echo /images$i changed
            /usr/bin/curl $PURGE_URL=https://images1cdn.omeromer.com/images$i
            echo "/usr/bin/curl $PURGE_URL=https://images1cdn.omeromer.com/images$i"
          done
       LTIME=$ATIME
       cat /var/log/lsyncd/lsyncd.log > /tmp/lsyncd.log.tmp
   fi
   sleep 5
done
