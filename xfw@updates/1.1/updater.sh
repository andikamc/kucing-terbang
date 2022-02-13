#!/bin/bash
mv_ver="1.1"
sc_ver=$(cat /home/ver)

#
rm /usr/bin/update
wget -q -O /usr/bin/update "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/update.sh"
chmod +x /usr/bin/update && shc -f /usr/bin/update -o /usr/bin/update && rm /usr/bin/update.*

# change version
echo "$mv_ver" > /home/ver
echo "Script updated to $mv_ver from $sc_ver"