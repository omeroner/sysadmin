### GNU Paralel

GNU Parallel, işleri Bash ortamında paralel olarak çalıştırmak için kullanılan bir araçtır.

bknz. [parallel tutorial](https://www.gnu.org/software/parallel/parallel_tutorial.html)

### Install
```sh
   $ sudo yum install parallel
   $ (wget -O - pi.dk/3 || curl pi.dk/3/ ||    fetch -o - http://pi.dk/3) | bash
```
### Examples
```sh
    $parallel ::: prog1 prog2
```

```sh
    $ parallel echo ::: alpha beta gamma
    alpha
    beta
    gamma
```
```sh
$ parallel echo ::: 0 1 ::: 0 1
0 0
0 1
1 0
1 1
```
```sh
$ parallel echo {} ::: /tmp
/tmp
```
```sh
$ parallel echo {/} ::: /tmp/stdio.h
stdio.h
```
```sh
$ parallel echo {//} ::: /tmp/stdio.h
/tmp
```
```sh
$ parallel echo {.} ::: /tmp/stdio.h
/tmp/stdio
```
```sh
$ parallel sleep {}\; echo {} ::: 5 2 1 4 3
1
2
4
3
5
```
```sh
$ parallel -k sleep {}\; echo {} ::: 5 2 1 4 3
5
2
1
4
3
```
```sh
$ seq 10 | parallel -n0 echo "Hello, World"
Hello, World
Hello, World
Hello, World
Hello, World
Hello, World
Hello, World
Hello, World
Hello, World
Hello, World
Hello, World
```
```sh
$ parallel --dry-run -k sleep {}\; echo {} ::: 5 2 1 4 3
sleep 5; echo 5
sleep 2; echo 2
sleep 1; echo 1
sleep 4; echo 4
sleep 3; echo 3
```
```sh
$ parallel --eta -k sleep {}\; echo {} ::: 5 2 1 4 3

Computers / CPU cores / Max jobs to run
1:local / 4 / 4

Computer:jobs running/jobs completed/%of started jobs/Average seconds to complete
ETA: 5s 1left 1500avg  local:1/4/100%/1.0s 
2
1
4
3
ETA: 1s 0left 1.00avg  local:0/5/100%/1.0s 
```
```sh
$ parallel gzip ::: *.log
```
```sh
$ parallel gunzip ::: *.gz
```
```sh
$ find . -name '*.jpg' | parallel convert -resize 512x384 {} {}_web.jpg
```
```sh
$ parallel wget ::: www.kernel.org/pub/linux/kernel/v3.x/linux-3.11.tar.xz \
                    www.kernel.org/pub/linux/kernel/v3.x/linux-3.10.10.tar.xz
```
```sh
$ parallel -a input.txt wget

The file “input.txt” contains:

https://www.kernel.org/pub/linux/kernel/v3.x/linux-3.11.tar.xz
https://www.kernel.org/pub/linux/kernel/v3.x/linux-3.10.10.tar.xz
```
```sh
$ find . -name \*.tar.xz | parallel tar xvf
```
```sh
$ cat hosts.txt 
1 127.0.0.1
2 localhost
You can run the tests in parallel using the following code:

$ parallel -a hosts.txt --colsep ' ' ping -c {1} {2}

PING 127.0.0.1 (127.0.0.1) 56(84) bytes of data.
64 bytes from 127.0.0.1: icmp_seq=1 ttl=64 time=0.074 ms

--- 127.0.0.1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.074/0.074/0.074/0.000 ms

PING localhost.localdomain (127.0.0.1) 56(84) bytes of data.
64 bytes from localhost.localdomain (127.0.0.1): icmp_seq=1 ttl=64 time=0.035 ms
64 bytes from localhost.localdomain (127.0.0.1): icmp_seq=2 ttl=64 time=0.065 ms

--- localhost.localdomain ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1000ms
rtt min/avg/max/mdev = 0.035/0.050/0.065/0.015 ms
```
```sh
GNU Parallel can also execute jobs on remote machines, for which you need to first test that ssh works:

$ SERVER1=localhost
$ ssh $SERVER1 echo "Eureka"
guest@localhost's password: 
Eureka
You can then invoke commands or scripts to be run on SERVER1, as shown below:
```
```sh
$  parallel -S $SERVER1 echo "Eureka from " ::: $SERVER1
guest@localhost's password: 
Eureka from localhost
Files can also be transferred to remote machines using the ’–transfer’ option. Rsync is used internally for the transfer. An example is shown below:
```
```sh
$  parallel -S $SERVER1 --transfer cat ::: /tmp/host.txt 
guest@localhost's password: 
1 127.0.0.1
2 localhost
```








