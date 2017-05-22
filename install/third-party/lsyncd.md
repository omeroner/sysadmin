[Lsyncd](https://code.google.com/archive/p/lsyncd/)

## Install
  Fedora series
 ```sh
    sudo yum install lua lua-devel rsync
    sudo yum install lsyncd
 ```

  Ubuntu type
 ```sh
    sudo apt-get install lsyncd
 ```

## Configuration

Lsyncd.conf
 ` vim /etc/lsyncd.conf `


 ```sh
settings {
        logfile = "/var/log/lsyncd/lsyncd.log",
        statusFile = "/var/log/lsyncd/lsyncd-status.log",
        statusInterval = 10,
        delay = 3
    }

sync {
    default.rsync,
    delete = false,
    source="/data/ApacheDocs/htdocs/images/",
    target="username@ipaddress:/data/ApacheDocs/htdocs/images/",
    exclude = { 'sitemap_*.xml*','robots.txt*' },
    rsync = {
        compress = false,
        acls = false,
        perms = true,
        verbose = true,
}

}
sync {
    default.rsync,
    delete = false,
    source="/data/ApacheDocs/htdocs2/images/",
    target="usrname@ipaddress:/data/ApacheDocs/htdocs2/images/",
    exclude = { 'sitemap_*.xml*','robots.txt*' },
    rsync = {
        compress = false,
        acls = false,
        perms = true,
        verbose = true,
}

}
 ```
 
## Service Start

 ```sh
   sudo cp lsyncd.conf /etc
   sudo systemctl enable lsyncd.service
   sudo systemctl start lsyncd.service
 ```
