#!/bin/bash
mv_ver="1.1"
sc_ver=$(cat /home/ver)

# change version
echo "$mv_ver" > /home/ver
echo "Script updated to $mv_ver from $sc_ver"