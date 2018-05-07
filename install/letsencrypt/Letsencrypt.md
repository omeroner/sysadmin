# Install Letsencrypt Nginx Centos 7 

## install certbot
      sudo yum install epel-release
      sudo yum update
      sudo yum install certbot

## install nginx
      sudo yum install nginx
      sudo systemctl start nginx

## config firewall
if firewall exist on centos do :

      sudo firewall-cmd --permanent --add-service=http --add-service=https
      sudo firewall-cmd --reload
      sudo firewall-cmd --list-services
      dhcpv6-client http ssh https

## create certbot 
      sudo systemctl stop nginx
      sudo certbot certonly -d <domain_names>
      sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048

## update nginx config 

      server {
         listen 80;
         server_name <domain-name>;
         return 301 https://$server_name$request_uri;
      }

      server {
          listen	 443 ssl;
          server_name  <domain-name>;

          ssl_certificate /etc/letsencrypt/live/<domain-name>/fullchain.pem;
          ssl_certificate_key /etc/letsencrypt/live/<domain-name>/privkey.pem;
          ssl_session_cache shared:SSL:1m;
          ssl_session_timeout  10m;
          ssl_ciphers HIGH:!aNULL:!MD5;
          ssl_prefer_server_ciphers on;
          ssl_dhparam /etc/ssl/certs/dhparam.pem;

          location / {
              proxy_set_header Host	   $host;
              proxy_set_header X-Real-IP  $remote_addr;
              proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
              proxy_pass http://localhost:8080;
          }

      }

## start nginx 
sudo systemctl start nginx

## create SSL auto renew
letsencryst has an expired data, create renew script to auto renew

      sudo nano /etc/cron.daily/letsencrypt-renew

update script

      #!/bin/sh
      if certbot renew > /var/log/letsencrypt/renew.log 2>&1 ; then
         nginx -s reload
      fi
      exit
      
      
start update 2 times a day      

      sudo chmod +x /etc/cron.daily/letsencrypt-renew
      01 02,14 * * * /etc/cron.daily/letsencrypt-renew
      

## Manual renew

      sudo systemctl stop nginx
      certbot renew
   
