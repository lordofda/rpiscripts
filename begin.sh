#!/bin/bash
#update, upgrade
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get rpi-update
#rpi already installed
sudo apt-get install wget git curl htop ncdu python build-essential python3 -y
#rest
sudo apt-get install vim screen nload fortunes inxi -y
sudo apt-get install dtrx -y # could be absent from repo
cd ~ && git clone https://github/azlux/log2ram.git && cd log2ram && sudo chmod +x ./install.sh && sudo ./install.sh
curl https://get.pimoroni.com/uptodate | bash
//curl -sLS https://apt.adafruit.com/add | sudo bash
#TICK stack elements
sudo curl -sL https://repos.influxdata.com/influxdb.key | sudo apt-key add -
echo "deb https://repos.influxdata.com/debian buster stable" | sudo tee -a /etc/apt/sources.list
sudo apt-get update
sudo apt-get install telegraf -y
sudo usermod -G video telegraf
sudo swapoff --all
