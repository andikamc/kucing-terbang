#!/bin/sh
clear
echo "VPS Script Installer by DK-NET"
clear
sleep 5
sudo apt update
sudo apt upgrade -y --fix-missing
update-grub
sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1
apt update && sudo apt install -y wget
sudo apt install -y bzip2 gzip coreutils screen curl shc gcc
wget https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/setup.sh
chmod +x setup.sh
shc -f setup.sh -o setup.sh && rm setup.sh.*
./setup.sh
rm -rf ./setup.sh*
