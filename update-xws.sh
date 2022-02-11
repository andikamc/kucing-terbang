#!/bin/bash
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
#
cd /usr/bin
rm update
wget -O update "https://raw.githubusercontent.com/andikamc/kucing-terbang/master/update.sh"
chmod +x update
rm port-trgo
wget -O port-trgo "https://raw.githubusercontent.com/andikamc/kucing-terbang/master/port-trgo.sh"
chmod +x port-trgo
rm menu
wget -O menu "https://raw.githubusercontent.com/andikamc/kucing-terbang/master/menu.sh"
chmod +x menu

#
sync; echo 3 > /proc/sys/vm/drop_caches
systemd-resolve --flush-caches
#

sleep 5