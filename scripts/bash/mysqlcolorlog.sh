#!/bin/sh
tail -f -n200 /var/lib/mysql/logs/error.log | awk '/Note/ {print "\033[32m" $0 "\033[39m"}/Warning/ {print "\033[31m" $0 "\033[39m"}'
