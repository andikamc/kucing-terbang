#!/bin/bash

chown -R www-data:www-data /etc/msmtprc
cd /usr/bin
wget --no-verbose -q -O autobackup "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/autobackup.sh"
wget --no-verbose -q -O backup "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/backup.sh"
wget --no-verbose -q -O restore "https://raw.githubusercontent.com/andikamc/kucing-terbang/kucingku/restore.sh"
chmod +x autobackup
shc -f autobackup -o autobackup && rm autobackup.*
chmod +x backup
shc -f backup -o backup && rm backup.*
chmod +x restore
shc -f restore -o restore && rm restore.*
cd
rm -f /root/set-br.sh
