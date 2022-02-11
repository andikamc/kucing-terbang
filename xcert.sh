#!/bin/bash
echo start
sleep 0.5
source /var/lib/premium-script/ipvps.conf
domain=$IP
systemctl stop xray
systemctl stop xray@none
systemctl stop xray@vless
systemctl stop xray@vnone
openssl genrsa -out /etc/v2ray/v2ray.key
openssl req -new -x509 -days 3650 -key /etc/v2ray/v2ray.key -out /etc/v2ray/v2ray.crt -subj "/C=ID"
openssl req -new -x509 -days 3650 -key /etc/v2ray/v2ray.key -out /etc/v2ray/v2ray.crt -subj "/C=ID/CN=$domain"
systemctl start xray
systemctl start xray@none
systemctl start xray@vless
systemctl start xray@vnone
echo Done
sleep 0.5
clear 
neofetch