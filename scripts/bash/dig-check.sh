#!/bin/bash
# omer oner 29 April 2016
DOMAINLIST=$(cat /tmp/fulldnsej.txt)

for DOMAIN in $DOMAINLIST; do
NS=$(dig NS $DOMAIN +short | head -1 )
A=$(dig A $DOMAIN +short | head -1 )
MX=$(dig MX $DOMAIN +short | head -1 )
echo -e   "$DOMAIN NS Record ==> $NS  A Record ==> $A MX Record ==> $MX"
done
