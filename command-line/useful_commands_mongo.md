### Total Connection Count
```sh
db.currentOp(true).inprog.reduce(
  (accumulator, connection) => {
    ipaddress = connection.client ? connection.client.split(":")[0] : "Internal";
    accumulator[ipaddress] = (accumulator[ipaddress] || 0) + 1;
    accumulator["TOTAL_CONNECTION_COUNT"]++;
    return accumulator;
  },
  { TOTAL_CONNECTION_COUNT: 0 }
)
```
### Profiler
```sh
$ mongo
MongoDB shell version: 2.4.9
connecting to: test
> use myDb
switched to db myDb
> db.getProfilingLevel()
0
> db.setProfilingLevel(2)
{ "was" : 0, "slowms" : 1, "ok" : 1 }
> db.getProfilingLevel()
2
> db.system.profile.find().pretty()


Level.  Description
0.      The profiler is off and does not collect any data. This is the default profiler level.
1.      The profiler collects data for operations that take longer than the value of slowms.
2.      The profiler collects data for all operations.
```






https://docs.mongodb.com/v4.4/reference/method/db.setProfilingLevel/
