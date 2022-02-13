#!/bin/sh
clear
echo "VPS Script Installer by DK-NET"
sleep 5
#
MYIP=$(wget -qO- ipinfo.io/ip);
IZIN=$( curl https://raw.githubusercontent.com/andikamc/kucing-terbang/master/ip_addr | grep $MYIP )
if [ $MYIP = $IZIN ]; then
clear
echo "Starting Setup Installer ..."
else
echo "Whoops 😘"
sleep 15
exit 0
fi
#
sleep 3
sudo apt update
sudo apt upgrade -y --fix-missing
update-grub
sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1
sudo apt install -y wget bzip2 gzip build-essential coreutils screen curl shc gcc
cd /tmp
wget --no-verbose -q -O /tmp/setup "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/setup.sh"
chmod +x /tmp/setup
shc -f /tmp/setup -o /tmp/setup && rm /tmp/setup.* && sh -c /tmp/setup
rm -rf ./setup*
