### Wordpress user parolası değiştirme
```sh
UPDATE wp_users SET user_pass=MD5('lO.fX-]}BP$J')WHERE wp_users.ID=1
```

### 3306 Port Sniff
```sh
tshark -d tcp.port==3306,mysql -T fields -R mysql.query -e frame.time -e ip.src -e ip.dst -e mysql.query 
tshark -i eth0 -aduration:60 -d tcp.port==3306,mysql -T fields -e mysql.query 'port 3306'
tshark -i eth4     -aduration:60     -d tcp.port==3306,mysql     -T fields     -e mysql.query 'port 3306'

tcpdump -i eth1 -s 1500 -w - -l port 3306 | strings | grep 'access denied'
tcpdump -s 1500 -w tcp.out port 3306
strings tcp.out
```

### Mysql sunucuya gelen queryleri sniff edip, sql proxy kullanmadan yakalayıp, okunabilir format'ta printleye bilirsiniz. Bunun için aşağıdaki işlemler yeterli.
```sh
Gerekli gördüğünüz kadar sniff
tshark -i eth0 port 3306 -s 1500 -w capture
sonra;
tshark -r capture -d tcp.port=3306,mysql -T fields -e mysql.query > queryler.log
okuna bilir formatta querylerinizi queryler.log dosyasında görebilirsiniz.


sudo tcpdump -i lo -s 0 -l -w - dst port 3306 | strings | perl -e '
while(<>) { chomp; next if /^[^ ]+[ ]*$/;
  if(/^(SELECT|UPDATE|DELETE|INSERT|SET|COMMIT|ROLLBACK|CREATE|DROP|ALTER)/i) {
    if (defined $q) { print "$q\n"; }
    $q=$_;
  } else {
    $_ =~ s/^[ \t]+//; $q.=" $_";
  }
}'
```


### Replikasyon skip error
```sh
stop slave; set global sql_slave_skip_counter = 1; start slave;
```

### Mysql Ouery Log 
```sh
tail -fn 1000 /var/lib/mysql/mysqld-slow.log |grep -B20 -A20 --colour "13:"|grep -A20 -b20 --colour "Query_time"
watch -n 1 "echo "show full processlist" | mysql | grep -vi "sleep" | more"
watch -n 1 "echo "show full processlist" | mysql | grep -vi "sleep" | wc -l"
```

### Mysql Error Log anlamlı bir şekilde renklendirip ekrana basar.
```sh
tail -f  /var/lib/mysql/logs/error.log| awk '/Note/{print "\033[32m" $0 "\033[39m"} /Warning/ {print "\033[31m" $0 "\033[39m"}'
```

###  How to Save results from MySQL into an external file

1. From the MySQL command line
```sh
SELECT columns FROM table_name WHERE whatever='something' INTO OUTFILE "/tmp/outfile.txt";
```
2. From the command line
2.A. Piping the SQL into the database
```sh
echo "SELECT columns FROM table_name WHERE whatever='something'" | /path/to/mysql -uUSERNAME -pPASSWORD DATABASENAME > /tmp/outfile.txt;
```
2.B. Using an external SQL file.
```sh
/path/to/mysql -uUSERNAME -pPASSWORD DATABASENAME < /tmp/sql.sql > /tmp/outfile.txt;
```


### Mysql slow query log quick parse
```sh
# Script used to quickly get a glance of how many queries since a certain time period were longer than X seconds

# Customize these 2 parameters

STARTDATE="120413"  # 2 Digit Year, 2 Digit Month, 2 Digit Day

QUERYTIME=3.0

# Runs the commands and prints out Query_time lines

FIRST=`grep -n -m 1 "# Time: $STARTDATE" /var/log/mysql-slow.log | cut -d : -f 1`; TOTAL=`wc -l /var/log/mysql-slow.log | cut -d ' ' -f 1`; tail -n `echo "$TOTAL-$FIRST" | bc` /var/log/mysql-slow.log | grep Query_time | awk -v time="$QUERYTIME" '$3 > time {print; }'
```

### Kulaniciya gore processleri kill etme
```sh
mysql -NBe "SELECT CONCAT('KILL ', id, ';') FROM information_schema.processlist WHERE user = 'some_username';" | mysql -vv
```

### Slowlog debug etme
```sh
mysqldumpslow -s c -t 10
mysqldumpslow -a -s r -t 5 /var/log/mysql/mysql-slow.log
```

### Sleep time 1 n’den büyük process’leri kill etme
```sh
select concat('KILL ',id,';') from information_schema.processlist where command = 'Sleep' and time > 1 into outfile '/tmp/4.txt';
mysql -e “ source 4.txt” 
```

### Batch Mode
```sh
As a partial answer: mysql -N -B -e "select people, places from things"

-N tells it not to print column headers. -B is "batch mode", and uses tabs to separate fields.

mysql -N -B -e "select people, places from things"
```

### REPLİKASYON
```sh
master host and pozisyon
CHANGE MASTER TO MASTER_HOST='10.132.134.150', MASTER_USER='slave_user', MASTER_PASSWORD= 'x0y!tra;18', MASTER_LOG_FILE='mysql-bin.001276', MASTER_LOG_POS=163989932;

change master to MASTER_HOST='10.132.134.150', MASTER_LOG_FILE='mysql-bin.000674', MASTER_LOG_POS=0;

CHANGE MASTER TO master_log_file='mysql-bin.000271',master_log_pos=0;


CHANGE MASTER TO
MASTER_HOST='10.10.190.191',
MASTER_USER='slave_user',
MASTER_PASSWORD='x0y!tra;18',
MASTER_LOG_FILE='mysql-bin.000007',
MASTER_LOG_POS=107;
                   
GRANT REPLICATION SLAVE ON *.* TO 'slave_user'@'%' IDENTIFIED BY 'x0y!tra;18';
```

### DB Size
```sh
SELECT count(*) tables,
concat(round(sum(table_rows)/1000000,2),'M') rows,
concat(round(sum(data_length)/(1024*1024*1024),2),'G') data,
concat(round(sum(index_length)/(1024*1024*1024),2),'G') idx,
concat(round(sum(data_length+index_length)/(1024*1024*1024),2),'G') total_size,
round(sum(index_length)/sum(data_length),2) idxfrac
FROM information_schema.TABLES;
```
### Db size
```sh
SELECT table_schema "Data Base Name", sum( data_length + index_length ) / 1024 / 1024 "Data Base Size in MB", sum( data_free )/ 1024 / 1024 "Free Space in MB" FROM information_schema.TABLES GROUP BY table_schema;
```

### Table size

```sh
SELECT concat(table_schema,'.',table_name),
concat(round(table_rows/1000000,2),'M') rows,
concat(round(data_length/(1024*1024*1024),2),'G') DATA,
concat(round(index_length/(1024*1024*1024),2),'G') idx,
concat(round((data_length+index_length)/(1024*1024*1024),2),'G') total_size,
round(index_length/data_length,2) idxfrac
FROM information_schema.TABLES
ORDER BY data_length+index_length DESC LIMIT 20;
```

### Table size by db
```sh
SELECT concat(table_schema,'.',table_name),
concat(round(table_rows/1000000,2),'M') rows,
concat(round(data_length/(1024*1024*1024),2),'G') DATA,
concat(round(index_length/(1024*1024*1024),2),'G') idx,
concat(round((data_length+index_length)/(1024*1024*1024),2),'G') total_size,
round(index_length/data_length,2) idxfrac
FROM information_schema.TABLES where table_schema='expose2'
ORDER BY data_length+index_length DESC LIMIT 20;
```


### Cron ile Binary log Purge etme
```sh
cron
-----
0 23 * * * mysql -uroot -e 'PURGE BINARY LOGS BEFORE DATE_SUB( NOW( ), INTERVAL 3 DAY)' > /dev/null 2>&1


query
-----
sonlog
purge master logs before 'now';


PURGE BINARY LOGS TO 'mnverona-bin.000191';

mysql> show master logs;
+---------------------+------------+
| Log_name            | File_size  |
+---------------------+------------+
| mnverona-bin.000191 | 1074476472 |
| mnverona-bin.000192 | 1075014618 |
| mnverona-bin.000193 | 1074219877 |
| mnverona-bin.000194 | 1073773618 |
| mnverona-bin.000195 | 1077064519 |
| mnverona-bin.000196 | 1097023635 |
| mnverona-bin.000197 | 1073741894 |
| mnverona-bin.000198 | 1077914364 |
| mnverona-bin.000199 | 1205354058 |
| mnverona-bin.000200 | 1074219302 |
| mnverona-bin.000201 | 1076849327 |
| mnverona-bin.000202 | 1077407340 |
| mnverona-bin.000203 |  296470910 |
+---------------------+------------+
13 rows in set (0.01 sec)

mysql>

30 gunden eski mysql binary log dosyalarini siler.
mysql -uroot -preload -e 'PURGE BINARY LOGS BEFORE DATE_SUB( NOW( ), INTERVAL 30 DAY)' > /dev/null 2>&1  

```

### InnoDB DATA ve INDEX Size Hesaplama
```sh
SELECT SUM(data_length)/POWER(1024,2) InnoDBData,
SUM(index_length)/POWER(1024,2) InnoDBIndexes
FROM information_schema.tables WHERE engine='InnoDB';
```
### MyISAM ve InnoDB'de ne kadar gerçek veri depoladığı
```sh
SELECT IFNULL(B.engine,'Total') "Storage Engine",
CONCAT(LPAD(REPLACE(FORMAT(B.DSize/POWER(1024,pw),3),',',''),17,' '),' ',
SUBSTR(' KMGTP',pw+1,1),'B') "Data Size", CONCAT(LPAD(REPLACE(
FORMAT(B.ISize/POWER(1024,pw),3),',',''),17,' '),' ',
SUBSTR(' KMGTP',pw+1,1),'B') "Index Size", CONCAT(LPAD(REPLACE(
FORMAT(B.TSize/POWER(1024,pw),3),',',''),17,' '),' ',
SUBSTR(' KMGTP',pw+1,1),'B') "Table Size"FROM (SELECT ENGINE,SUM(data_length) DSize,SUM(index_length) ISize,
SUM(data_length+index_length) TSize FROM information_schema.tables
WHERE table_schema NOT IN ('mysql','information_schema','performance_schema')AND ENGINE IS NOT NULL GROUP BY ENGINE WITH ROLLUP) B,(SELECT 3 pw) A ORDER BY TSize;
```
### Veritabani karakter lerini gormek icin
```sh
For Schemas:
SELECT default_character_set_name FROM information_schema.SCHEMATA S
WHERE schema_name = "schemaname";
For Tables:
SELECT CCSA.character_set_name FROM information_schema.`TABLES` T,
       information_schema.`COLLATION_CHARACTER_SET_APPLICABILITY` CCSA
WHERE CCSA.collation_name = T.table_collation
  AND T.table_schema = "schemaname"
  AND T.table_name = "tablename";
For Columns:
SELECT character_set_name FROM information_schema.`COLUMNS` C
WHERE table_schema = "schemaname"
  AND table_name = "tablename"
  AND column_name = "columnname";
  ```
### Kullanıcı Oluşturma
```sh
CREATE USER 'operasyon'@'%' IDENTIFIED BY PASSWORD 'tgbn852';
GRANT SELECT ON *.* TO 'operasyon'@'%';
flush privileges;
```

### Percona Toolkit
```sh
pt-table-checksum --host=10.10.140.27 --user=percona --password=reload --set-vars innodb_lock_wait_timeout=50 --no-check-binlog-format --nocheck-replication-filters --databases=community --tables=messages

time pt-table-sync --sync-to-master h=10.10.140.27,u=percona,p=reload --databases=community --table=messages --no-bin-log --no-check-slave --print > FILE 2>&1
```


  
  Faydalı Linkler:
  http://www.debianhelp.co.uk/mysqltips.htm
  https://www.percona.com/doc/percona-toolkit/3.0/index.html
  https://github.com/vlad-github/mysql-health-check
