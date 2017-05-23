
### MYSQL ALIAS
```sh
alias mysql="mysql --login-path=root"
alias mysqldata="cd /var/lib/mysql/data/"
alias mysqltmp="cd /var/lib/mysql/tmp/"
alias mysqlrun="cd /var/lib/mysql/run/"
alias mysqllog="cd /var/lib/mysql/logs/"
alias mysqldir="cd /var/lib/mysql/"
alias mysqlsniff="tshark -d tcp.port==3306,mysql -T fields -R mysql.query -e frame.time -e ip.src -e ip.dst -e mysql.query"
alias mysqllog="bash /data/scripts/mysqlcolorlog.sh"
alias slowlog="tail -fn 1000 /var/lib/mysql/logs/slow.log |grep -B20 -A20 --colour "15"|grep -A20 -b20 --colour \"Query_time\""
alias mysqltuning1="perl /data/scripts/mysqltuner.pl"
alias mysqltuning2="bash /data/scripts/tuning-primer.sh"
alias mysqltop='watch -n 1 "echo "show full processlist" | mysql --login-path=root | grep -vi "sleep" | more"'
alias masterstatus='mysql -e "show master status"'
alias slavestatus='mysql -e "show slave status\G;"'
alias mycnf='vim /etc/my.cnf'
```

### /data/scripts/mysqlcolorlog.sh
https://raw.githubusercontent.com/omeroner/sysadmin/master/scripts/bash/mysqlcolorlog.sh

