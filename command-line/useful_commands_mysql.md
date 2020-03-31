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
