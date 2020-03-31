#!/bin/bash
# omer oner 21/11/2013
# nginx access log rotate


server="10.10.165.50"
log_dir="/mnt/gezio_httplogs/nginx/"
#date_dir=`date +%Y/%m/%d/%H`   
date_dir=`date +%Y/%m/%d`
time="$(date +%H:%M:%S)"
/bin/mkdir -p ${log_dir}/${server}/${date_dir} > /dev/null 2>&1
/bin/mv ${log_dir}/access.log ${log_dir}/${server}/${date_dir}/access.log
#/bin/mv ${log_dir}/error.log ${log_dir}/${date_dir}/error.log

kill -USR1 `cat /var/run/nginx.pid`

/bin/gzip ${log_dir}/${server}/${date_dir}/access.log &
#/bin/gzip ${log_dir}/${date_dir}/error.log &
