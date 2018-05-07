#!/bin/bash
service= service_name
pid=`/bin/pidof $service_name`
tarih=`date`

if [ "$pid" -gt "0" ]; then
        echo "$service_name calisiyor"
        echo "$tarih - $service_name calisiyor..." >> /root/scripts/$service_name_check.log
else
        /usr/sbin/service $service_name restart
        echo "$tarih - $service_name calismiyor. Restart edildi" >> /root/scripts/$service_name_check.log
fi
