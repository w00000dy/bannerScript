#!/bin/bash

lightCyan='\033[1;36m'
NC='\033[0m' # No Color

printf "${lightCyan}Uninstall neofetch${NC}\n"
apt remove neofetch -y

printf "${lightCyan}Install fastfetch${NC}\n"
add-apt-repository ppa:zhangsongcui3371/fastfetch -y
apt install fastfetch -y

printf "${lightCyan}Remove /etc/update-motd.d/01-neofetch file${NC}\n"
rm -f /etc/update-motd.d/01-neofetch

printf "${lightCyan}Create /etc/update-motd.d/01-fastfetch file${NC}\n"
rm -f /etc/update-motd.d/01-fastfetch
cp -v 01-neofetch /etc/update-motd.d/01-fastfetch
chmod 755 /etc/update-motd.d/01-fastfetch

printf "${lightCyan}Create /etc/ssh/banner file${NC}\n"
rm -f /etc/ssh/banner
cp -v banner /etc/ssh/banner

printf "${lightCyan}Customize SSH configuration (/etc/ssh/sshd_config)${NC}\n"
sed -i 's/#Banner none/Banner \/etc\/ssh\/banner/g' /etc/ssh/sshd_config

printf "${lightCyan}Restart SSH service${NC}\n"
systemctl restart ssh.service
