#!/bin/bash
cd /usr/bin
wget -O update "https://raw.githubusercontent.com/andikamc/kucing-terbang/master/update.sh"
chmod +x update
wget -O port-trgo "https://raw.githubusercontent.com/andikamc/kucing-terbang/master/port-trgo.sh"
chmod +x port-trgo


#
sync; echo 3 > /proc/sys/vm/drop_caches
systemd-resolve --flush-caches
#