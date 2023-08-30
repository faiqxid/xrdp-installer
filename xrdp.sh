#!/bin/bash
echo -e "\e[1m\e[32m ________   __ ______ ___  _____ _____   ___________ \e[0m"
echo -e "\e[1m\e[32m | ___ \ \ / / |  ___/ _ \|_   _|  _  | |_   _|  _  \\e[0m"
echo -e "\e[1m\e[32m | |_/ /\ V /  | |_ / /_\ \ | | | | | |   | | | | | |\e[0m"
echo -e "\e[1m\e[32m | ___ \ \ /   |  _||  _  | | | | | | |   | | | | | |\e[0m"
echo -e "\e[1m\e[32m | |_/ / | |   | |  | | | |_| |_\ \/' /  _| |_| |/ / \e[0m"
echo -e "\e[1m\e[32m \____/  \_/   \_|  \_| |_/\___/ \_/\_\  \___/|___/  \e[0m"
echo -e "\e[1m\e[32m                                                     \e[0m"
echo -e "\e[1m\e[32m                                                     \e[0m"
echo -e "\e[1m\e[32m 							\e[0m\n"
echo -e "\e[1m\e[32m AUTO INSTALL XRDP ON UBUNTU\e[0m\n\n"
sleep 5
echo -e "\e[1m\e[32m1. Updating packages... \e[0m" && sleep 1
apt update && apt upgrade -y

echo -e "\e[1m\e[32m2. Installing dependencies... \e[0m" && sleep 1
apt install ubuntu-desktop -y
sleep 1
apt install xrdp -y
sleep 1
apt install python3-pip -y
sleep 1
apt install python3-tk -y
sleep 1
apt install python3-dev -y
sleep 1
adduser xrdp ssl-cert
echo -e "\e[1m\e[32m3. set repo... \e[0m" && sleep 1
apt install software-properties-common apt-transport-https wget ca-certificates gnupg2 ubuntu-keyring -y
wget -O- https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor |  tee /usr/share/keyrings/google-chrome.gpg

echo -e "\e[1m\e[32m4. setup repo... \e[0m" && sleep 1
echo deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main |  tee /etc/apt/sources.list.d/google-chrome.list
clear
echo -e "\e[1m\e[32m5. install Chrome.... \e[0m" && sleep 1
apt update && apt install google-chrome-stable -y

echo -e "\e[1m\e[32m6. install ngrok.... \e[0m" && sleep 1
curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc |  tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && echo "deb https://ngrok-agent.s3.amazonaws.com buster main" |  tee /etc/apt/sources.list.d/ngrok.list &&  apt update &&  apt install ngrok
echo -n "Masukan Auth Token Ngrok : ";
read autngrok;
ngrok config add-authtoken $autngrok

echo -e "\e[1m\e[32m7. Set Up XRDP.... \e[0m" && sleep 1
startwm_file="/etc/xrdp/startwm.sh"
lines_to_add="unset DBUS_SESSION_BUS_ADDRESS\nunset XDG_RUNTIME_DIR"
sed -i "/test -x \/etc\/X11\/Xsession && exec \/etc\/X11\/Xsession/i $lines_to_add" "$startwm_file"
systemctl restart xrdp

echo -e "\e[1m\e[32m8. get host vnc  .... \e[0m" && sleep 1


screen -dmS xrdp
sleep 1
screen -S xrdp -X stuff "ngrok tcp 3389
"

echo -e "\e[1m\e[32m9. get host vnc  .... \e[0m" && sleep 1

screen -r xrdp
