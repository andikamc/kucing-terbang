#!/bin/bash
clear
echo -e "\e[94m  .----------------------------------------------------.    "
echo -e "\e[94m  |            XRAY VMESS & VLESS PORT                 |    "
echo -e "\e[94m  '----------------------------------------------------'    "
echo -e "\e[0m                                                               "
echo -e "\e[1;31m* [1]\e[0m  \e[1;32m: PORT VMESS XRAY\e[0m"
echo -e "\e[1;31m* [2]\e[0m  \e[1;32m: PORT VLESS XRAY\e[0m"
echo -e "\e[1;31m* [3]\e[0m  \e[1;32m: PORT VLESS XTLS XRAY\e[0m"
echo -e "\e[1;31m* [x]\e[0m  \e[1;32m: Menu\e[0m"
echo -e ""
echo -e ""
read -p "        Select From Options [1-3 or x]: " menuxx
echo -e ""
case $menuxx in
1)
port-xws
;;
2)
port-xvless
;;
3)
port-xray
;;
x)
menu
;;
*)
echo " Please enter an correct number!!"
;;
esac
