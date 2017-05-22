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
    target="lighttpd@195.87.93.144:/data/ApacheDocs/htdocs/images/",
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
    source="/data/ApacheDocs/htdocs-macro/images/",
    target="lighttpd@195.87.93.144:/data/ApacheDocs/htdocs-macro/images/",
    exclude = { 'sitemap_*.xml*','robots.txt*' },
    rsync = {
        compress = false,
        acls = false,
        perms = true,
        verbose = true,
}

}
 ``


}

Start the lsyncd daemon
 Fedora series)
   Sudo cp lsyncd.conf / etc
   Sudo systemctl enable lsyncd.service
   Sudo systemctl start lsyncd.service

 Ubuntu type)
   Sudo mkdir / etc / lsyncd
   Sudo cp lsyncd.conf /etc/lsyncd/lsyncd.conf.lua
   Sudo edit / etc / default / rsync
        RSYNC_ENABLE = true

   Sudo edit /etc/init/lsyncd.conf
    ------------------------------------------------------------------------------------ ----
    Description "lsyncd file syncronizer"
  
    Start on (starting network-interface
        Or starting network-manager
        Or starting networking)
  
    Stop on runlevel [! 2345]
    Expect fork
  
    Respawn
    Respawn limit 10 5
  
    Exec / usr / bin / lsyncd /etc/lsyncd/lsyncd.conf.lua
    ------------------------------------------------------------------------------------ ---------
     Confirm daemon settings
     Sudo initctl check-config lsyncd

   Sudo initctl start lsyncd
