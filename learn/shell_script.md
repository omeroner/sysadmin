### Special Shell Variables.
***
## $IFS

IFS varsayılan değeri bir boşluk, bir sekme ve bir satırsonu karakteridir.
```sh
cat /tmp/domains.txt
```

```sh
cyberciti.biz|202.54.1.1|/home/httpd|ftpcbzuser
nixcraft.com|202.54.1.2|/home/httpd|ftpnixuser
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


***

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
