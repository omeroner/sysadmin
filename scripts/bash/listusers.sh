#!/bin/bash

_l="/etc/login.defs"
_p="/etc/passwd"
## get mini UID limit ##
l=$(grep "^UID_MIN" $_l)
## get max UID limit ##
l1=$(grep "^UID_MAX" $_l)
## use awk to print if UID >= $MIN and UID <= $MAX and shell is not /sbin/nologin   ##
echo -e  "\033[31;4m----------[ Normal User Accounts ]---------------\033[0m\n"
awk -F':' -v "min=${l##UID_MIN}" -v "max=${l1##UID_MAX}" '{ if ( $3 >= min && $3 <= max  && $7 != "/sbin/nologin" ) print $0 }' "$_p"
echo ""
echo -e  "\033[31;4m----------[ System User Accounts ]---------------\033[0m\n"
awk -F':' -v "min=${l##UID_MIN}" -v "max=${l1##UID_MAX}" '{ if ( !($3 >= min && $3 <= max  && $7 != "/sbin/nologin")) print $0 }' "$_p"
