#!/bin/bash

lightCyan='\033[1;36m'
NC='\033[0m' # No Color

skip_fastfetch=""
echo "$@"
# Loop through all parameters
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --skip_fastfetch) # If the parameter --long is found
            skip_fastfetch="1"
            ;;
    esac
    shift # Jump to the next argument
done

printf "${lightCyan}Uninstall neofetch${NC}\n"
apt remove neofetch -y

if [[ "$skip_fastfetch" == "1" ]]; then
  printf "${lightCyan}Install fastfetch${NC}\n"
  apt install software-properties-common -y
  add-apt-repository ppa:zhangsongcui3371/fastfetch -y
  apt install fastfetch -y
else
  printf "${lightCyan}Skip fastfetch installation${NC}\n"
fi

printf "${lightCyan}Remove /etc/update-motd.d/01-neofetch file${NC}\n"
rm -f /etc/update-motd.d/01-neofetch

printf "${lightCyan}Create /etc/update-motd.d/01-fastfetch file${NC}\n"
rm -f /etc/update-motd.d/01-fastfetch
cp -v 01-fastfetch /etc/update-motd.d/01-fastfetch
chmod 755 /etc/update-motd.d/01-fastfetch

printf "${lightCyan}Create /etc/ssh/banner file${NC}\n"
rm -f /etc/ssh/banner
cp -v banner /etc/ssh/banner

printf "${lightCyan}Customize SSH configuration (/etc/ssh/sshd_config)${NC}\n"
sed -i 's/#Banner none/Banner \/etc\/ssh\/banner/g' /etc/ssh/sshd_config

printf "${lightCyan}Restart SSH service${NC}\n"
systemctl restart ssh.service
