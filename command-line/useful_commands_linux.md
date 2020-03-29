
###  LİSTELEME
Symlink dizinlerindeki dosyalar da dahil olmak üzere bir dizindeki tüm dosyaları özyinelemeli olarak listeleme
```sh
ls -LR
find -follow
find -L
tree -l
```

###  VIM NGINX RENKLENDİRME
```sh
#!/bin/bash
#
# Highligh Nginx config file in Vim

# Download syntax highlight
mkdir -p ~/.vim/syntax/
wget http://www.vim.org/scripts/download_script.php?src_id=19394 -O ~/.vim/syntax/nginx.vim

# Set location of Nginx config file
cat > ~/.vim/filetype.vim <<EOF
au BufRead,BufNewFile /etc/nginx/*,/etc/nginx/conf.d/*,/usr/local/nginx/conf/* if &ft == '' | setfiletype nginx | endif
EOF
```

###  ^M KARAKTERİNİ VIM İLE TEMİZLEME
```sh
:%s/^M//g
:%s/\^M//
:%s/\r//g 
:%s/\r/\r/g
sed -i -e 's/\r//g'
```

### CERTBOT İLE SERTİFİKA OLUŞTURMA CF
```sh
certbot certonly --rsa-key-size 4096 --agree-tos --manual-public-ip-logging-ok --email="oner@onkatec.com" --server=https://acme-v02.api.letsencrypt.org/directory --dns-cloudflare --dns-cloudflare-credentials=/etc/letsencrypt/cloudflare2.ini --domain="*.DOMAİN.com"  --domain="DOMAİN.com"
```

### MYSQL USER CREATE
```sh
GRANT USAGE ON onkatec.* TO 'admin'@'%' IDENTIFIED BY 'password1';
GRANT ALL privileges ON *.* TO 'admin'@'%';
SET GLOBAL validate_password_policy = 0
```
```sh
mysql> SHOW VARIABLES LIKE 'validate_password%';
+--------------------------------------+--------+
| Variable_name                        | Value  |
+--------------------------------------+--------+
| validate_password_check_user_name    | OFF    |
| validate_password_dictionary_file    |        |
| validate_password_length             | 8      |
| validate_password_mixed_case_count   | 1      |
| validate_password_number_count       | 1      |
| validate_password_policy             | MEDIUM |
| validate_password_special_char_count | 1      |
+--------------------------------------+--------+

mysql> SET GLOBAL validate_password_length = 6;
mysql> SET GLOBAL validate_password_number_count = 0;
mysql> SET GLOBAL validate_password.policy = LOW;

```

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
Sitenin hayatta olup olmadığını kontrol etmenin en basit yolu için aşağıdaki yöntemi kullanabilirsiniz
```sh
curl -Is http://www.google.com | head -n 1
curl www.google.com -s -f -o /dev/null || echo "Website down." | mail -s "Website is down" admin@omeroner.com 

```
Toplu dosya bul ve taşı
```sh
find . -iname "*imren*.mp3" -exec mv {} /Volumes/external/1-MUSIC/cengiz imren/   \;
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

```sh
find . | wc -l
find . -printf "%h\n" | cut -d/ -f-2 | sort | uniq -c | sort -rn
echo "Detailed Inode usage for: $(pwd)" ; for d in `find -maxdepth 1 -type d |cut -d\/ -f2 |grep -xv . |sort`; do c=$(find $d |wc -l) ; printf "$c\t\t- $d\n" ; done ; printf "Total: \t\t$(find $(pwd) | wc -l)\n"
Detailed Inode usage for: /home/2daygeek
```

Toplu dosya bul ve taşı
```sh
find . -iname "*imren*.mp3" -exec mv {} /Volumes/external/1-MUSIC/cengiz imren/   \;
```
Zero size files
```sh
find ./ -type f -size 0
find ./ -type f -empty
find ./ -type f -size 0 -exec rm -f {} \;
find ./ -type f -size 0 | xargs rm -f
find ./ -type f -size 0 -delete
```
Empty directories
```sh
find ./ -type d -empty
find ./ -depth -type d -empty -exec rmdir {} \;
find ./ -type d -empty -delete
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

### RANDOM PASSWORD OLUŞTURMA
```sh
DEBIAN/UBUNTU
# apt-get install -y pwgen
FEDORA
# dnf install -y pwgen
CENTOS
# yum install -y pwgen

pwgen
pwgen -s
pwgen -s -1
pwgen -s -1 14
pwgen -s 15 2
pwgen -s 10 5 -1 -y
pwgen -s 80 -1 -v -c -0

$ cat users-list.txt 
user1
user2
user3
user4
user5
user6
user7
user8
user9
user10

for i in $( cat users-list.txt ); do pwgen -s -1 15 1 | sed "s/^/$i /"; done
user1 tRVd0cbtviFN9oj
user2 QJQeELnhxqeg3v3
user3 u11HAOYWlSyJDPv
user4 BalUhUbmejS5HHW
user5 PzTz7UV3Kp4yeBb
user6 QVa8ZYkuM3wJI77
user7 dFF3GwAauBIPvc9
user8 tinOKCsHaD3NYkO
user9 mNfTtjp7dL6aUPw
user10 UnZulfCEz6yFhLJ
```
