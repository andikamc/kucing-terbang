#!/bin/bash
echo start
sleep 0.5
source /var/lib/premium-script/ipvps.conf
domain=$IP
systemctl stop v2ray
systemctl stop v2ray@none
openssl genrsa -out /etc/v2ray/v2ray.key
openssl req -new -x509 -days 3650 -key /etc/v2ray/v2ray.key -out /etc/v2ray/v2ray.crt -subj "/C=ID/CN=$domain"
systemctl start v2ray
systemctl start v2ray@none
echo Done
sleep 0.5
clear 
neofetch
