https://muaazsalagar.com/how-to-backup-and-restore-redis-cache-data-from-a-kubernetes-cluster-to-another-cluster-pod-a-step-by-step-guide/

https://muaazsalagar.com/how-to-backup-and-restore-redis-cache-data-from-a-kubernetes-cluster-to-another-cluster-pod-a-step-by-step-guide/
 kubectl exec -it  redis-master-0 /bin/sh


kubectl exec -it  redis-master-0 /bin/sh
redis-cli -a yJAkVLNaC5

# Keyspace
db0:keys=5,expires=5,avg_ttl=583229
db1:keys=4720,expires=3263,avg_ttl=231306569
db2:keys=6288,expires=6286,avg_ttl=436793604
db4:keys=302,expires=0,avg_ttl=0


# Keyspace
db0:keys=5,expires=5,avg_ttl=467056
db1:keys=4718,expires=3261,avg_ttl=230275896
db2:keys=6287,expires=6285,avg_ttl=440156091
db4:keys=311,expires=1,avg_ttl=3568697


 AUTH password
info
select x
keys *
config get *
monitor

$ redis-cli
127.0.0.1:6379> AUTH yJAkVLNaC5
OK
127.0.0.1:6379>

127.0.0.1:6379> config get dir
1) "dir"
2) "/data"
127.0.0.1:6379>

127.0.0.1:6379> save


kubectl cp default/redis-master-0:/data/dump.rdb /home/admin/

scp admin@34.110.88.220:/home/admin/dump.rdb .

kubectl cp dump.rdb default/redis-master-0:data/dump.rdb


scp -r -i /Users/omeroner/Documents/Lingaros/pem-files/stagelinga.pem ubuntu@52.9.23.27:/home/ubuntu/dump.rdb  /Users/omeroner
