#!/bin/bash
sc_ver=$(cat /home/ver)
uuid=$(cat /proc/sys/kernel/random/uuid)
#
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
clear
echo "Starting Update ..."
sleep 3
apt -y update
clear

# // Download
wget --no-verbose -q -O /tmp/__tmp_update "https://raw.githubusercontent.com/andikamc/kebo-terbang/pangolier/$sc_ver/updater.sh?__no_cache=true&__fragment=$uuid"
echo "Starting Update Command ..."
chmod +x /tmp/__tmp_update && shc -f /tmp/__tmp_update -o /tmp/__tmp_update && sh -c /tmp/__tmp_update && rm -f /tmp/__tmp_update.*
echo "Update Done!"
echo "Fix minor Bugs"
echo "Now You Can Change Port Of Some Services"
sleep 5