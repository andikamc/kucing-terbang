#!/bin/bash
sc_ver=$(cat /home/ver)
#
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
clear
echo "Starting Update ..."
sleep 5

# // Download
wget -O /tmp/__tmp_update "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/xfw@updates/$sc_ver/updater.sh"
chmod +x /tmp/__tmp_update && shc -f /tmp/__tmp_update -o /tmp/__tmp_update && sh -c /tmp/__tmp_update && rm -f /tmp/__tmp_update.*
echo "Update Done!"
echo "Fix minor Bugs"
echo "Now You Can Change Port Of Some Services"
sleep 5
#