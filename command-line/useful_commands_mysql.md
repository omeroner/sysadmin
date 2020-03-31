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
