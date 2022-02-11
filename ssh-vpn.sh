#!/bin/bash
# By BOTVPN
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- ipinfo.io/ip);
clear
# initializing var
export DEBIAN_FRONTEND=noninteractive
MYIP=$(wget -qO- ipinfo.io/ip);
MYIP2="s/xxxxxxxxx/$MYIP/g";
NET=$(ip -o $ANU -4 route show to default | awk '{print $5}');
source /etc/os-release
ver=$VERSION_ID

#detail nama perusahaan
country=MY
state=Malaysia
locality=Malaysia
organization=RAHCHIEL.xyz
organizationalunit=RAHCHIEL.xyz
commonname=RAHCHIEL.xyz

# simple password minimal
wget -O /etc/pam.d/common-password "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/password"
chmod +x /etc/pam.d/common-password

# go to root
cd

# Edit file /etc/systemd/system/rc-local.service
cat > /etc/systemd/system/rc-local.service <<-END
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
[Install]
WantedBy=multi-user.target
END

# nano /etc/rc.local
cat > /etc/rc.local <<-END
#!/bin/sh -e
# rc.local
# By default this script does nothing.
exit 0
END

# Ubah izin akses
chmod +x /etc/rc.local

# enable rc local
systemctl enable rc-local
systemctl start rc-local.service

# disable ipv6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local

#update
apt update -y
apt upgrade -y
apt dist-upgrade -y
apt-get remove --purge ufw firewalld -y
apt-get remove --purge exim4 -y

# install wget and curl
apt -y install wget curl

# set time GMT +8
ln -fs /usr/share/zoneinfo/Asia/Malaysia /etc/localtime

# set locale
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config

# install
apt-get --reinstall --fix-missing install -y bzip2 gzip coreutils wget screen rsyslog iftop htop net-tools zip unzip wget net-tools curl nano sed screen gnupg gnupg1 bc apt-transport-https build-essential dirmngr libxml-parser-perl neofetch git lsof
echo "clear" >> .profile
echo "neofetch --ascii_distro Minix" >> .profile

# install webserver
apt -y install nginx
cd
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget -O /etc/nginx/nginx.conf "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/nginx.conf"
mkdir -p /home/vps/public_html
wget -O /etc/nginx/conf.d/vps.conf "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/vps.conf"
/etc/init.d/nginx restart

# install badvpn
cd
wget -O /usr/bin/badvpn-udpgw "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/badvpn-udpgw64"
chmod +x /usr/bin/badvpn-udpgw
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500' /etc/rc.local
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7400 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7500 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7600 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7700 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7800 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7900 --max-clients 500

# setting port ssh
sed -i 's/Port 22/Port 22/g' /etc/ssh/sshd_config

# install dropbear
apt -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=143/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 109"/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
/etc/init.d/dropbear restart

# install squid
cd
apt -y install squid3
wget -O /etc/squid/squid.conf "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/squid3.conf"
sed -i $MYIP2 /etc/squid/squid.conf

# setting vnstat
apt -y install vnstat
/etc/init.d/vnstat restart
apt -y install libsqlite3-dev
wget https://humdi.net/vnstat/vnstat-2.6.tar.gz
tar zxvf vnstat-2.6.tar.gz
cd vnstat-2.6
./configure --prefix=/usr --sysconfdir=/etc && make && make install
cd
vnstat -u -i $NET
sed -i 's/Interface "'""eth0""'"/Interface "'""$NET""'"/g' /etc/vnstat.conf
chown vnstat:vnstat /var/lib/vnstat -R
systemctl enable vnstat
/etc/init.d/vnstat restart
rm -f /root/vnstat-2.6.tar.gz
rm -rf /root/vnstat-2.6

# install stunnel
apt install stunnel4 -y
cat > /etc/stunnel/stunnel.conf <<-END
cert = /etc/stunnel/stunnel.pem
client = no
socket = a:SO_REUSEADDR=1
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1

[dropbear]
accept = 1443
connect = 127.0.0.1:109

[dropbear]
accept = 777
connect = 127.0.0.1:22

[openvpn]
accept = 442
connect = 127.0.0.1:1194

END

# make a certificate
openssl genrsa -out key.pem 2048
openssl req -new -x509 -key key.pem -out cert.pem -days 1095 \
-subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname/emailAddress=$email"
cat key.pem cert.pem >> /etc/stunnel/stunnel.pem

# konfigurasi stunnel
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
/etc/init.d/stunnel4 restart

#OpenVPN
wget https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/vpn.sh &&  chmod +x vpn.sh && ./vpn.sh

# install fail2ban
apt -y install fail2ban

# Install DDoS Deflate
apt install -y dnsutils tcpdump dsniff grepcidr
wget -qO ddos.zip "https://raw.githubusercontent.com/Hanxhin/Autoscript/main/FILES/ddos-deflate.zip"
unzip ddos.zip
cd ddos-deflate
chmod +x install.sh
./install.sh
cd
rm -rf ddos.zip ddos-deflate

# banner /etc/issue.net
echo "Banner /etc/issue.net" >>/etc/ssh/sshd_config
sed -i 's@DROPBEAR_BANNER=""@DROPBEAR_BANNER="/etc/issue.net"@g' /etc/default/dropbear

# blockir torrent
iptables -A FORWARD -m string --string "get_peers" --algo bm -j DROP
iptables -A FORWARD -m string --string "announce_peer" --algo bm -j DROP
iptables -A FORWARD -m string --string "find_node" --algo bm -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
iptables -A FORWARD -m string --algo bm --string ".torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
iptables -A FORWARD -m string --algo bm --string "torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce" -j DROP
iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload

# download script
cd /usr/bin
wget -O add-host "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/add-host.sh"
wget -O about "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/about.sh"
wget -O menu "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/menu.sh"
wget -O usernew "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/usernew.sh"
wget -O trial "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/trial.sh"
wget -O hapus "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/hapus.sh"
wget -O member "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/member.sh"
wget -O delete "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/delete.sh"
wget -O cek "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/cek.sh"
wget -O restart "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/restart.sh"
wget -O speedtest "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/speedtest_cli.py"
wget -O info "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/info.sh"
wget -O ram "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/ram.sh"
wget -O renew "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/renew.sh"
wget -O autokill "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/autokill.sh"
wget -O ceklim "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/ceklim.sh"
wget -O limit-speed "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/limit-speed.sh"
wget -O tendang "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/tendang.sh"
wget -O change-port "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/change.sh"
wget -O port-ovpn "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/port-ovpn.sh"
wget -O port-ssl "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/port-ssl.sh"
wget -O port-wg "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/port-wg.sh"
wget -O port-tr "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/port-tr.sh"
wget -O port-sstp "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/port-sstp.sh"
wget -O port-squid "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/port-squid.sh"
wget -O port-ws "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/port-ws.sh"
wget -O port-vless "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/port-vless.sh"
wget -O port-xray "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/port-xray.sh"
wget -O wbmn "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/webmin.sh"
wget -O xp "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/xp.sh"
wget -O menu-vmess "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/menu-vmess.sh"
wget -O menu-vless "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/menu-vless.sh"
wget -O menu-l2tp "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/menu-l2tp.sh"
wget -O menu-pptp "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/menu-pptp.sh"
wget -O menu-sstp "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/menu-sstp.sh"
wget -O menu-ss "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/menu-ss.sh"
wget -O menu-ssr "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/menu-ssr.sh"
wget -O menu-trojan "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/menu-trojan.sh"
wget -O menu-wg "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/menu-wg.sh"
wget -O menu-ssh "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/menu-ssh.sh"
wget -O menu-xray "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/menu-xray.sh"
wget -O running "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/running.sh"
wget -O menu-trgo "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/menu-trgo.sh"
wget -O add-dom "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/cf/add-dom.sh"
wget -O add-cff "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/cf/add-cff.sh"
wget -O add-cfh "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/cf/add-cfh.sh"
wget -O menu-cf "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/menu-cf.sh"
wget -O kernel-updt "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/kernel-updt.sh"
wget -O autoreboot "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/autoreboot.sh"
wget -O update "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/update.sh"
wget -O menu-trgo "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/menu-trgo.sh"
wget -O menu-xx "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/menu-xx.sh"
wget -O bbr "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/bbr.sh"
chmod +x bbr && shc -f bbr -o bbr && rm bbr.*
chmod +x menu-xx && shc -f menu-xx -o menu-xx && rm menu-xx.*
chmod +x menu-trgo && shc -f menu-trgo -o menu-trgo && rm menu-trgo.*
chmod +x update && shc -f update -o update && rm update.*
chmod +x autoreboot && shc -f autoreboot -o autoreboot && rm autoreboot.*
chmod +x kernel-updt && shc -f kernel-updt -o kernel-updt && rm kernel-updt.*
chmod +x menu-cf && shc -f menu-cf -o menu-cf && rm menu-cf.*
chmod +x add-cfh && shc -f add-cfh -o add-cfh && rm add-cfh.*
chmod +x add-cff && shc -f add-cff -o add-cff && rm add-cff.*
chmod +x add-dom && shc -f add-dom -o add-dom && rm add-dom.*
chmod +x running && shc -f running -o running && rm running.*
chmod +x add-host && shc -f add-host -o add-host && rm add-host.*
chmod +x menu && shc -f menu -o menu && rm menu.*
chmod +x usernew && shc -f usernew -o usernew && rm usernew.*
chmod +x trial && shc -f trial -o trial && rm trial.*
chmod +x hapus && shc -f hapus -o hapus && rm hapus.*
chmod +x member && shc -f member -o member && rm member.*
chmod +x delete && shc -f delete -o delete && rm delete.*
chmod +x cek && shc -f cek -o cek && rm cek.*
chmod +x restart && shc -f restart -o restart && rm restart.*
chmod +x speedtest && shc -f speedtest -o speedtest && rm speedtest.*
chmod +x info && shc -f info -o info && rm info.*
chmod +x about && shc -f about -o about && rm about.*
chmod +x autokill && shc -f autokill -o autokill && rm autokill.*
chmod +x tendang && shc -f tendang -o tendang && rm tendang.*
chmod +x ceklim && shc -f ceklim -o ceklim && rm ceklim.*
chmod +x limit-speed && shc -f limit-speed -o limit-speed && rm limit-speed.*
chmod +x ram && shc -f ram -o ram && rm ram.*
chmod +x renew && shc -f renew -o renew && rm renew.*
chmod +x change-port && shc -f change-port -o change-port && rm change-port.*
chmod +x port-ovpn && shc -f port-ovpn -o port-ovpn && rm port-ovpn.*
chmod +x port-ssl && shc -f port-ssl -o port-ssl && rm port-ssl.*
chmod +x port-wg && shc -f port-wg -o port-wg && rm port-wg.*
chmod +x port-sstp && shc -f port-sstp -o port-sstp && rm port-sstp.*
chmod +x port-tr && shc -f port-tr -o port-tr && rm port-tr.*
chmod +x port-squid && shc -f port-squid -o port-squid && rm port-squid.*
chmod +x port-ws && shc -f port-ws -o port-ws && rm port-ws.*
chmod +x port-vless && shc -f port-vless -o port-vless && rm port-vless.*
chmod +x wbmn && shc -f wbmn -o wbmn && rm wbmn.*
chmod +x xp && shc -f xp -o xp && rm xp.*
chmod +x menu-vmess && shc -f menu-vmess -o menu-vmess && rm menu-vmess.*
chmod +x menu-vless && shc -f menu-vless -o menu-vless && rm menu-vless.*
chmod +x menu-l2tp && shc -f menu-l2tp -o menu-l2tp && rm menu-l2tp.*
chmod +x menu-pptp && shc -f menu-pptp -o menu-pptp && rm menu-pptp.*
chmod +x menu-sstp && shc -f menu-sstp -o menu-sstp && rm menu-sstp.*
chmod +x menu-ss && shc -f menu-ss -o menu-ss && rm menu-ss.*
chmod +x menu-ssr && shc -f menu-ssr -o menu-ssr && rm menu-ssr.*
chmod +x menu-trojan && shc -f menu-trojan -o menu-trojan && rm menu-trojan.*
chmod +x menu-wg && shc -f menu-wg -o menu-wg && rm menu-wg.*
chmod +x menu-ssh && shc -f menu-ssh -o menu-ssh && rm menu-ssh.*
chmod +x menu-xray && shc -f menu-xray -o menu-xray && rm menu-xray.*
echo "0 5 * * * root reboot" >> /etc/crontab
echo "0 0 * * * root xp" >> /etc/crontab
# remove unnecessary files
cd
apt autoclean -y
apt -y remove --purge unscd
apt-get -y --purge remove samba*;
apt-get -y --purge remove apache2*;
apt-get -y --purge remove bind9*;
apt-get -y remove sendmail*
apt autoremove -y
# finishing
cd
chown -R www-data:www-data /home/vps/public_html
/etc/init.d/nginx restart
/etc/init.d/openvpn restart
/etc/init.d/cron restart
/etc/init.d/ssh restart
/etc/init.d/dropbear restart
/etc/init.d/fail2ban restart
/etc/init.d/stunnel4 restart
/etc/init.d/vnstat restart
/etc/init.d/squid restart
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7400 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7500 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7600 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7700 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7800 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7900 --max-clients 500
history -c
echo "unset HISTFILE" >> /etc/profile

cd
rm -f /root/key.pem
rm -f /root/cert.pem
rm -f /root/ssh-vpn.sh

# finihsing
clear
