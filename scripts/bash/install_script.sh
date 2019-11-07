#!/usr/bin/env bash
# Bootstraps & Updates the lingapos Intranet Sync Server
# Author: Mahendran Kathirvel (mahendrank@benseron.com)
# OS: Ubuntu 16.04, systemd
# Last updated: 14/03/2018

# Set host name fro the device
function setHostname {
    echo '>>> Setting hostname'
    sudo sh -c -e "echo 'intrasync.local' > /etc/hostname" && 
    sudo sh -c -e "echo '127.0.0.1	intrasync.local' >> /etc/hosts"
    echo '>>> Done'
}

# Setup redis server
function setupRedisServer {
   echo '>>> Installing redis server'
   sudo apt-get update && 
   sudo apt-get -y upgrade && 
   sudo apt-get -y install redis-server &&
   sudo apt-get -y remove &&
   sudo apt-get -y autoremove &&
   sudo apt-get -y clean &&
   sudo apt-get -y autoclean

   if [ $? -ne 0 ]; then
       echo 'failed to install redis server'
       exit 1
   fi

   sudo systemctl enable redis-server.service
   echo '>>> Done'
}

# Setup syncserver
function setupSynserverBinary {
    cleanUP
    echo '>>> Fetching syncserver binary from s3'
    wget -t 3 -O /tmp/syncserver.tar.gz $S3_URL/syncserver.tar.gz
    if [ $? -ne 0 ]; then
        echo 'failed to fetch syncserver'
	exit 1
    fi

    CHECKSUM1=$(wget -qO- "$S3_URL/md5sum.txt")
    CHECKSUM2=$(md5sum /tmp/syncserver.tar.gz | awk '{print $1}')
    
    if [ "$CHECKSUM1" != "$CHECKSUM2" ]; then
	echo 'invalid binary'
        exit 1
    fi
    
    sudo tar -C /opt -xzf /tmp/syncserver.tar.gz
    sudo chmod +x /opt/syncserver/linga-syncserver
    echo '>>> Done'
}

# Clean up utility
function cleanUP {
    echo '>>> Cleaning up tmp folder'
    rm -f /tmp/syncserver.tar.gz
    echo '>>> Done'
}

echo `date`
echo "---------------------------------------------------------------" 
DIR=$HOME
S3_URL="https://s3-us-west-2.amazonaws.com/intranetsync"
LATEST=$(wget -qO- "$S3_URL/version.txt")

if [[ "$*" == "init" ]]; then
    echo '>>> Bootstrapping LingaPOS syncserver'
    if [ -f $DIR/syncserver_version.txt ]; then
      echo 'Already bootstrapped.'
      echo 'Exiting...'
      exit 0
    fi

    setupRedisServer
    sleep 3
    setupSynserverBinary

    SYSD_SCRIPT='# Systemd unit file for Linga Syncserver
[Unit]
Description=Intranet Syncserver
After=syslog.target network.target
BindsTo=redis-server.service

[Service]
Type=simple
WorkingDirectory=/opt/syncserver
ExecStart=/opt/syncserver/linga-syncserver
RestartSec=10s
Restart=always

[Install]
WantedBy=multi-user.target'

    touch linga-syncserver.service
    echo "$SYSD_SCRIPT" > linga-syncserver.service
    sudo mv linga-syncserver.service /etc/systemd/system/
    sudo systemctl daemon-reload
    sudo systemctl enable linga-syncserver.service

    #echo '>>> Starting essential services'
    #sudo systemctl start redis-server.service
    #sleep 3
    #sudo systemctl start linga-syncserver.service
    #echo '>>> Done'

    echo '>>> Setting version'
    touch $DIR/syncserver_version.txt
    echo $LATEST > $DIR/syncserver_version.txt
    echo '>>> Done'

    setHostname

    echo 'Lingapos syncserver bootstrapped successfully'
    cleanUP
    echo "---------------------------------------------------------------" 
    echo 'Rebooting system...'
    sudo reboot
    exit 0
fi

CURRENT=$(cat $DIR/syncserver_version.txt)

if [ "$*" == "update" ]; then
    echo 'Updating Lingapos syncserver'

    if [ "$LATEST" == "$CURRENT" ]; then
       echo 'No updates found.'
       echo 'exiting...'
       exit 0
    fi

    sudo systemctl stop linga-syncserver.service
    sleep 3
    sudo rm -rf /opt/syncserver
    setupSynserverBinary

    sudo systemctl start linga-syncserver.service
    #sudo systemctl restart redis-server.service

    echo '>>> Updating linga version'
    echo $LATEST > $DIR/syncserver_version.txt
    echo '>>> Done'

    cleanUP
    echo "syncserver has been successfully updated."
    echo "---------------------------------------------------------------"
    echo 'exiting...'
    exit 0
fi
echo 'Nothing to do. Try ./sync_device init or update'
