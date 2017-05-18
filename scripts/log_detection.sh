#!/bin/sh
# HTTP Log File "Client IP Adresses" Anomaly Detection


#log_file=/mnt/mn_http_logs/10.10.140.11/2015/03/17/restful-mobile-request-2015-03-17_05.log
log_file=/var/log/jetty/access.log
temp_file=/tmp/detecting_http_ip.txt
msg1="HTTP log file is fine.Client WAN IP adress is coming."

   if [ ! -f "$log_file" ]; then
          echo "HTTP log file ( '$log_file' ) doesn't found!"
      exit 1
      else

function logread() {
          tail -n 500 $log_file|grep -v -w '"GET /version "' > $temp_file
          readcheck=`echo $?`
   if [ "$readcheck" -ne "0" ]
       then
       echo "Occurred an error while log file is reading."
       exit 1
       fi
}

f5_ips="
x.x.x.x
"

logread;
count=`for ip in $(echo $f5_ips); do egrep "$ip" $temp_file|awk {'print $1'}|wc -l; done`
sumit=`for i in $(echo "$count"); do let sum+=i;
       done ; echo $sum`

   if [ "$sumit" -ge "5" ]; then
            sleep 3
            logread;
      else
      echo "$msg1"
      rm -f $temp_file
      exit 0
   fi

   for i in {5..11}; do let sum+=i;

   if [ "$sumit" -ge "$i" ]; then
            sleep 3
            logread;
      else
      exit 0
   fi
done

        sleep 6
        logread;
        x=12
   if [ "$sumit" -ge "$x" ]; then
      echo "Detecting an anomaly! Check http log file for wan ip adress.";
      else
      exit 0
   fi
fi
