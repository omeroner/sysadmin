
### TOP / PS
io yapan process'leri bulmak
```sh
while true; do date; ps auxf | awk '{if($8=="D") print $0;}'; sleep 1; done
```

### CRONTAP
Sn'lik cron
```sh
while true; do  /usr/local/php/bin/php /var/www/html/apps.oyun.mynet.com/batch/riffi.php ; sleep 4 ; done
```


### NETSTAT
```sh
netstat -atun | awk '{print $5}' | cut -d: -f1 | sed -e '/^$/d' |sort | uniq -c | sort -n
netstat -an | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | sort | uniq -c
```

### ECHO
Kelimeyi renklendirme
```sh
echo -e '\E[37;44m'"\033[1m*********192.168.41.81 UPDATE OLAN DOSYALAR************\033[0m"
```

Kelimeyi tırnak içine alma
```sh
echo name,id,3 | awk '{print "\x22" $1 "\x22"}'
"name,id,3”
```


### TELNET
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


### MOUNT
Qnap vol mount
```sh
sudo mount -t cifs -o username=omeroner,password=PASSWORD //192.168.131.22/omeroner /mmt/vol_omeroner
```

### FIND
100 MB üzeri file bulma
```sh
find / -type f -size +10000k -exec ls -lh {} \;| awk '{ print $5 ": " $9 }'
```

Sıkıştırılmamış dosyaları bulup sıkıştırma
```sh
find .  -type f ! -name "*.gz" -exec gzip -v {} \;
```

### RSYNC
1 sn arayla sürekli rsync
```sh
while /bin/true; do rsync -aSHv --progress /mnt/vols/ /mnt/vols_new; sleep 1; done
```

### OPENSSL
Sertifika istek dosyası CSR oluşturma
```sh
openssl req -new -newkey rsa:2048 -nodes -out www_onkatec_com.csr -keyout www_onkatec_com.key -subj "/C=TR/ST=Atasehir/L=Istanbul/O=Onkatec/OU=E-Ticaret/CN=www.onkatec.com"
```

