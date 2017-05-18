#!/bin/bash

<<comment
cat list.txt

https://server1.omeroner.com/20170406_15.jpg
https://server1.omeroner.com/20170406_16.jpg
https://server1.omeroner.com/20170406_17.jpg
https://server1.omeroner.com/20170406_14.jpg
https://server1.omeroner.com/20170406_18.jpg
https://server1.omeroner.com/20170406_19.jpg
https://server1.omeroner.com/20170406_20.jpg
https://server1.omeroner.com/20170406_22.jpg
https://server1.omeroner.com/20170406_23.jpg
https://server1.omeroner.com/20170406_21.jpg
https://server1.omeroner.com/20170420_15.jpg
https://server1.omeroner.com/20170406_24.jpg
comment



# Our custom function
cust_func(){
  wget -q "$1"
}
 
while IFS= read -r url
do
        cust_func "$url" &
done < list.txt
 
wait
echo "All files are downloaded."

