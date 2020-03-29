#!/bin/bash

dest="/data/logs"

find $dest -maxdepth 1 -name "*access*.log" -mtime +2 -exec gzip {} \;
mv $dest/*.gz $dest/logzip/
