
### Top / Ps
io yapan process'leri bulmak.
```sh
while true; do date; ps auxf | awk '{if($8=="D") print $0;}'; sleep 1; done
```

### Crontob
Sn'lik cron
```sh
while true; do  /usr/local/php/bin/php /var/www/html/apps.oyun.mynet.com/batch/riffi.php ; sleep 4 ; done
```


### Netstat
```sh
netstat -atun | awk '{print $5}' | cut -d: -f1 | sed -e '/^$/d' |sort | uniq -c | sort -n
netstat -an | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | sort | uniq -c
```

### Echo
```sh
echo -e '\E[37;44m'"\033[1m*********192.168.41.81 UPDATE OLAN DOSYALAR************\033[0m"
```







