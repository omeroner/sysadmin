#!/bin/bash 
# linux sunucuda herhangibi bir portta kaç adet connection sayisini gorebilmek ve banlamak.

netstat -na | grep ":80" | awk '{ print $5}'| cut -d":" -f1 | sort -n | uniq -c | awk '{if($1>30){print "echo baglanti sayisi:"$1" baglanti ipsi:"$2;print "iptables -A INPUT -s " $2 " -j DROP "}}'
