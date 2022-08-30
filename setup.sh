#!/bin/bash

lightCyan='\033[1;36m'
NC='\033[0m' # No Color

printf "${lightCyan}Installiere neofetch${NC}\n"
apt install neofetch -y

printf "${lightCyan}Erstelle /etc/update-motd.d/01-neofetch Datei${NC}\n"
rm -f /etc/update-motd.d/01-neofetch
cp -v 01-neofetch /etc/update-motd.d/01-neofetch
chmod 755 /etc/update-motd.d/01-neofetch

printf "${lightCyan}Erstelle /etc/ssh/banner Datei${NC}\n"
rm -f /etc/ssh/banner
cp -v banner /etc/ssh/banner

printf "${lightCyan}Erstelle /etc/ssh/neofetch.conf Datei${NC}\n"
rm -f /etc/ssh/neofetch.conf
cp -v config.conf /etc/ssh/neofetch.conf

printf "${lightCyan}Passe SSH-Konfiguration (/etc/ssh/sshd_config) an${NC}\n"
sed -i 's/#Banner none/Banner \/etc\/ssh\/banner/g' /etc/ssh/sshd_config

printf "${lightCyan}Starte SSH Service neu${NC}\n"
systemctl restart ssh.service
