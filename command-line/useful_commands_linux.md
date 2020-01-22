### İNDEX LİSTELEME ELASTİCSERCH
```sh
curl http://localhost:9200/_cat/indices?pretty
```

### GIT DOSYALARI SİLME
```sh
find . \( -name ".git" -o -name ".gitignore" -o -name ".gitmodules" -o -name ".gitattributes" \) -exec rm -rf -- {} +
```
```sh
( find . -type d -name ".git" && find . -name ".gitignore" && find . -name ".gitmodules" ) | xargs rm -rf
```

### EXTENSION CHANGE
```sh
for x in *.JPG; do mv "$x" "${x%.JPG}.jpg"; done
```

### JPEG COMPRESS
```sh
mogrify -strip -interlace Plane -sampling-factor 4:2:0 -quality 85% *.jpg
```
yükseklik en boy oranını koruyarak uygun şekilde ölçeklenir
```sh
mogrify -resize 960x528! *.png
```

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

### MAIL SEND ON CONSOLE 
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
### SPEED TEST INTERNET
```sh
curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -
```

### MONGO USER CREATE
```sh
use admin
db.createUser({ user:"USERNAME", pwd: "PASSWORD", roles: [{role: "userAdminAnyDatabase", db: "admin"}] })
```
