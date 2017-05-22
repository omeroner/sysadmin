cp /data/download/php-5.3.8/php.ini-production /usr/local/php5/lib/php.ini 
ln -s /usr/local/php5/lib/php.ini /etc/php.ini
cd /etc/
ll
vi php.ini 
vim /etc/php.ini dedikten sonra ilk olarak asagidaki degisiklikleri yapmamioz lazim.



date.timezone = "Europe/Istanbul"
short_open_tag = On   off u on yapicaksin

export PATH=/usr/local/php/bin/:$PATH
export PATH=/usr/local/mysql/bin/:$PATH

Installing shared extensions:     /usr/local/php/lib/php/extensions/no-debug-non-zts-20100525/

nstalling shared extensions:     /usr/local/php/lib/php/extensions/no-debug-non-
zts-20100525/

[root@OyunWeb memcache-2.2.6]# make install
Installing shared extensions:     /usr/local/php5/lib/php/extensions/no-debug-non-zts-20090626/
[root@OyunWeb memcache-2.2.6]# 

ini_set('display_errors', 0);
ini_set('log_errors', 1);
ini_set('error_log', dirname(__FILE__) . '/error_log.txt');
error_reporting(E_ALL);


expose_php off olcak