#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- ipinfo.io/ip);
clear
sleep 1
echo Cek Hak Akses...
sleep 0.5
cd
cd /etc/systemd/system/

#Install system auto run
wget --no-verbose -q -O /etc/systemd/system/ws-ssh.service https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/websocket/ws-ssh.service && chmod +x /etc/systemd/system/ws-ssh.service
wget --no-verbose -q -O /etc/systemd/system/ws-dropbear.service https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/websocket/ws-dropbear.service && chmod +x /etc/systemd/system/ws-dropbear.service
wget --no-verbose -q -O /etc/systemd/system/ws-ovpn.service https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/websocket/ws-ovpn.service && chmod +x /etc/systemd/system/ws-ovpn.service
wget --no-verbose -q -O /etc/systemd/system/ws-stunnel.service https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/websocket/ws-stunnel.service && chmod +x /etc/systemd/system/ws-stunnel.service

#Install Websocket-SSH
wget --no-verbose -q -O /usr/local/bin/ws-ssh https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/websocket/ws-openssh.py && chmod +x /usr/local/bin/ws-ssh
wget --no-verbose -q -O /usr/local/bin/ws-dropbear https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/websocket/ws-dropbear.py && chmod +x /usr/local/bin/ws-dropbear
wget --no-verbose -q -O /usr/local/bin/ws-ovpn https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/websocket/ws-ovpn.py && chmod +x /usr/local/bin/ws-ovpn
wget --no-verbose -q -O /usr/local/bin/ws-stunnel https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/websocket/ws-tls.py && chmod +x /usr/local/bin/ws-stunnel

#Enable, Start & Restart ws-ssh service
systemctl enable ws-ssh.service
systemctl start ws-ssh.service
systemctl restart ws-ssh.service

#Enable, Start & Restart ws-dropbear service
systemctl enable ws-dropbear.service
systemctl start ws-dropbear.service
systemctl restart ws-dropbear.service

#Enable, Start & Restart ws-ovpn service
systemctl enable ws-ovpn.service
systemctl start ws-ovpn.service
systemctl restart ws-ovpn.service

#Enable, Start & Restart ws-stunnel service
systemctl enable ws-stunnel.service
systemctl start ws-stunnel.service
systemctl restart ws-stunnel.service
