### Special Shell Variables.
## $IFS

IFS varsayılan değeri bir boşluk, bir sekme ve bir satırsonu karakteridir.
```sh
cat /tmp/domains.txt
```

```sh
omeroner.com|202.54.1.1|/home/httpd|ftpcbzuser
syslnx.net|202.54.1.2|/home/httpd|ftpnixuser
```

create setupapachevhost.sh
```sh
#!/bin/bash
# setupapachevhost.sh - Apache webhosting automation demo script
file=/tmp/domains.txt

# set the Internal Field Separator to |
IFS='|'
while read -r domain ip webroot ftpusername
do
        printf "*** Adding %s to httpd.conf...\n" $domain
        printf "Setting virtual host using %s ip...\n" $ip
        printf "DocumentRoot is set to %s\n" $webroot
        printf "Adding ftp access for %s using %s ftp account...\n\n" $domain $ftpusername
	
done < "$file"
```

Dosyayı kaydedin ve kapatın. Şöyle çalıştırın:
```sh
chmod +x setupapachevhost.sh
./setupapachevhost.sh
```
Örnek çıktılar:
```sh
*** Adding omeroner.com to httpd.conf...
Setting virtual host using 202.54.1.1 ip...
DocumentRoot is set to /home/httpd
Adding ftp access for omeroner.com using ftpcbzuser ftp account...

*** Adding syslnx.net to httpd.conf...
Setting virtual host using 202.54.1.2 ip...
DocumentRoot is set to /home/httpd
Adding ftp access for syslnx.net using ftpnixuser ftp account...
```

## $@,$*
$@ ve $*, özel kabuk değişkenleridir.
```
$@ Komut dosyasına geçirilen tüm argümanlar listesini tutar.
$* Komut dosyasına geçirilen tüm argümanlar listesini tutar.
```

```sh
#!/bin/bash
# ifsargs.sh - Cmd args - positional parameter demo
echo "Command-Line Arguments Demo"
echo "*** All args displayed using \$@ positional parameter ***"
echo $@
echo "*** All args displayed using \$* positional parameter ***"
echo $*
```
```sh
chmod +x ifsargs.sh
./ifsargs.sh omer oner not ıvır zıvır
```
Örnek çıktılar:
```sh
Command-Line Arguments Demo
*** All args displayed using $@ positional parameter ***
omer oner not ıvır zıvır
*** All args displayed using $* positional parameter ***
omer oner not ıvır zıvır
```


***
### Shell Script Put Multiple Line Comment

1.
```sh
    # my comment
```
2.
```sh
    <<COMMENT1
    your comment 1
    comment 2
    blah
    COMMENT1
```
3.
```sh
    : '
     your comments here
    '
```
***
