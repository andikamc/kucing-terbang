#!/bin/bash
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
#######################################################################################################cd /usr/bin
rm /usr/bin/menu
wget -O /usr/bin/menu "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/menu.sh"
chmod +x /usr/bin/menu && shc -f /usr/bin/menu -o /usr/bin/menu && rm /usr/bin/menu.*
rm /usr/bin/update
wget -O /usr/bin/update "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/update.sh"
chmod +x /usr/bin/update && shc -f /usr/bin/update -o /usr/bin/update && rm /usr/bin/update.*
#######################################################################################################

wget -O /usr/bin/add-trgo "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/add-trgo.sh"
wget -O /usr/bin/del-trgo "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/del-trgo.sh"
wget -O /usr/bin/cek-trgo "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/cek-trgo.sh"
wget -O /usr/bin/renew-trgo "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/renew-trgo.sh"
wget -O /usr/bin/port-trgo "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/port-trgo.sh"
chmod +x /usr/bin/add-trgo
chmod +x /usr/bin/del-trgo
chmod +x /usr/bin/cek-trgo
chmod +x /usr/bin/renew-trgo
chmod +x /usr/bin/port-trgo
shc -f /usr/bin/add-trgo -o /usr/bin/add-trgo && rm /usr/bin/add-trgo.*
shc -f /usr/bin/del-trgo -o /usr/bin/del-trgo && rm /usr/bin/del-trgo.*
shc -f /usr/bin/cek-trgo -o /usr/bin/cek-trgo && rm /usr/bin/cek-trgo.*
shc -f /usr/bin/renew-trgo -o /usr/bin/renew-trgo && rm /usr/bin/renew-trgo.*
shc -f /usr/bin/port-trgo -o /usr/bin/port-trgo && rm /usr/bin/port-trgo.*

#######################################################################################################
sync; echo 3 > /proc/sys/vm/drop_caches
systemd-resolve --flush-caches
#

# clear cache
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

echo "Update done.... Server will be restarted on 15 seconds"
sleep 15
clear
reboot