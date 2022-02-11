#!/bin/bash
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
#
cd /usr/bin
#
rm menu
wget -O menu "https://raw.githubusercontent.com/andikamc/kucing-terbang/master/menu.sh"
chmod +x menu && shc -f menu -o menu && rm menu.*
#
rm update
wget -O update "https://raw.githubusercontent.com/andikamc/kucing-terbang/master/update.sh"
chmod +x update && shc -f update -o update && rm update.*
#
rm limit-speed
wget -O limit-speed "https://raw.githubusercontent.com/andikamc/kucing-terbang/master/limit-speed.sh"
chmod +x limit-speed && shc -f limit-speed -o limit-speed && rm limit-speed.*

#
sync; echo 3 > /proc/sys/vm/drop_caches
systemd-resolve --flush-caches
#

# clear cache
apt update --fix-missing && \
    rm /etc/timezone && \
    echo "Asia/Jakarta" | sudo tee /etc/timezone && \
    rm -rf /tmp/* && \
    apt -y autoclean && \
    apt -yqq autoremove && \
    apt -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    touch /var/log/installed.log && \
    rm /var/log/*.log
#

sleep 5