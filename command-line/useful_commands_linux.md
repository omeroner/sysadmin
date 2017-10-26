
### Top / Ps
io yapan process'leri bulmak
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
Kelimeyi renklendirme
```sh
echo -e '\E[37;44m'"\033[1m*********192.168.41.81 UPDATE OLAN DOSYALAR************\033[0m"
```

Kelimeyi tırnak içine alma
```sh
echo name,id,3 | awk '{print "\x22" $1 "\x22"}'
"name,id,3”
```


### Telnet
apache check
```sh
telnet localhost 80 [enter]
GET /HTTP/1.0 [enter] [enter]or


Code:
telnet localhost 80 [enter]
HEAD /HTTP/1.0 [enter] [enter]
```

Mail Send 
```sh
$ telnet mail.syslnx.net 25
```
```sh
HELO linuxconfig.org
```
```sh
MAIL FROM: someaddress@syslnx.net
```
```sh
RCPT TO: some@email.add
```

```sh
DATA
Subject: Sending an email using telnet

Hello,

Here is my body? Do you like it?

cheers
.
```
```sh
quit
```

### CURL
Html'deki http(s) tüm linklerin listelenmesi ve curl ile sorgulanması
```sh
for i in `curl -s -L cnn.com |egrep --only-matching "http(s?):\/\/[^ \"\(\)\<\>]*" | uniq` ; do curl -s -I $i 2>/dev/null |head -n 1 | cut -d$' ' -f2; done
```
