


- http://www.mongodb.org/display/DOCS/Monitoring+and+Diagnostics

- http://craiccomputing.blogspot.com/2011/02/authentication-in-mongo-and-mongoid.html

- http://www.if-not-true-then-false.com/2010/install-mongodb-on-fedora-centos-red-hat-rhel/

```sh
vi /etc/yum.repos.d/10gen-mongodb.repo (içine alltaki satıra koy)


[10gen]
name=10gen Repository
baseurl=http://downloads-distro.mongodb.org/repo/redhat/os/x86_64
gpgcheck=0
```

### install
```sh
yum install mongo-10gen mongo-10gen-server (install et)
vi /etc/mongod.conf (config dosyası)
chown -R mongod:mongod /var/lib/mongo/
service mongod start
/etc/init.d/mongod start
```

### mongo use
```sh
> use test
switched to db test
> db.foo.find()
> db.foo.save({a: 1})
> db.foo.find()
{ "_id" : ObjectId("4b8ed53c4f450867bb35a1a9"), "a" : 1 }
> db.foo.update( {a: 1}, {a: 5})
> db.foo.find()
{ "_id" : ObjectId("4b8ed53c4f450867bb35a1a9"), "a" : 5 }
exit
```

```sh
vi /etc/sysconfig/iptables
- -A RH-Firewall-1-INPUT -m state --state NEW -m tcp -p tcp --dport 27017 -j ACCEPT
service iptables restart
```

### test remote connection

```sh
mongo server:port/database
mongo 10.0.10.45:27017/test
```


###  server için driver

- https://github.com/mongodb/mongo-php-driver
- https://download.github.com/mongodb-mongo-php-driver-1.1.4-55-g3a20db4.tar.gz--download et

```sh
-tar -xzvf mongodb-mongo-php-driver-1.1.4-55-g3a20db4.tar.gz
cd mongodb-mongo-php-driver-3a20db4/
phpize
./configure --with-php-config=/usr/local/php/bin/php-config
make
make install
```
```sh
extension=mongo.so to your php.ini file.
```

```sh
show dbs
use canak
db.addUser("admin","y!3er")
db.system.users.find()
db.printCollectionStats()
db.serverStatus()
db.stats()
db.shutdownServer()
db.system.namespaces.count()
db.getCollectionNames()
db.getLastError()
db.getMongo()
db.getName()
db.getProfilingLevel()
db.printShardingStatus()
db.onlineusers.count()
```

### backup

```sh
mkdir dump
mongodump
dump dizin altına bütün databaseleri atar
```




### example
```sh
db.auth ("canak","12345678");
mongodump -dcanak --username "canakuser" --password "12345678"
db.auth ("canak","12345678");
> use canak
switched to db canak
> db.auth ("canakokeyuser","12345678");
1
> show collections;
onlineusers
system.indexes
system.users
```

```sh
db.onlineusers.remove({}); -->truncate table
db.onlineusers.find() -->  --> bütün row'ları select eder
db.onlineusers.count() --> count alır
```
```sh
db.commandHelp(find) 
db.serverStatus("connections");
db.listCommands()
dbquery.shellbatchsize(50) 
```

- http://www.mongodb.org/display/DOCS/File+Based+Configuration


