#!/bin/sh
# service check and restart
# chmod +x launch.sh
# */1 * * * * /root/launch.sh

ps auxw | grep java | grep -v grep > /dev/null

if [ $? != 0 ]
then
        /bin/sh /root/scripts/pipe-search.sh > /dev/null
fi
