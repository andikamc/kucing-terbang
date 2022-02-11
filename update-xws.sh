#!/bin/bash
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
#
cd /usr/bin
#
rm /usr/bin/menu
wget -O /usr/bin/menu "https://raw.githubusercontent.com/andikamc/kucing-terbang/master/menu.sh"
chmod +x /usr/bin/menu && shc -f /usr/bin/menu -o /usr/bin/menu && rm /usr/bin/menu.*
#
rm /usr/bin/update
wget -O /usr/bin/update "https://raw.githubusercontent.com/andikamc/kucing-terbang/master/update.sh"
chmod +x /usr/bin/update && shc -f /usr/bin/update -o /usr/bin/update && rm /usr/bin/update.*
#
rm /usr/bin/limit-speed
wget -O /usr/bin/limit-speed "https://raw.githubusercontent.com/andikamc/kucing-terbang/master/limit-speed.sh"
chmod +x /usr/bin/limit-speed && shc -f /usr/bin/limit-speed -o /usr/bin/limit-speed && rm /usr/bin/limit-speed.*
#
rm /usr/bin/add-trgo
wget -O /usr/bin/add-trgo "https://raw.githubusercontent.com/andikamc/kucing-terbang/master/add-trgo.sh"
chmod +x /usr/bin/add-trgo && shc -f /usr/bin/add-trgo -o /usr/bin/add-trgo && rm /usr/bin/add-trgo.*

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