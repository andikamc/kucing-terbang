#!/bin/bash
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
# // Update
apt-get -y autoremove;
apt upgrade && apt replace -y

echo "Start Update"
sleep 5

# // Download
cd /usr/bin
wget -O update-xws "https://raw.githubusercontent.com/andikamc/kucing-terbang/master/update-xws.sh"
chmod +x update-xws
sh -c /usr/bin/update-xws
echo "0 5 * * * root clear-log && reboot" > /etc/crontab
echo "0 0 * * * root xp" > /etc/crontab
cd
echo "1.2" > /home/ver
clear
echo " Fix minor Bugs"
echo " Now You Can Change Port Of Some Services"
echo " Reboot 5 Sec"
sleep 5
rm -f update.sh
reboot
