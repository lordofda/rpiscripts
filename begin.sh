#!/bin/bash
#update, upgrade
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get rpi-update
#rpi already installed
sudo apt-get install wget git curl htop ncdu python build-essential python3 -y
#rest
sudo apt-get install vim dtrx screen nload fortunes inxi -y
curl https://get.pimoroni.com/uptodate | bash
//curl -sLS https://apt.adafruit.com/add | sudo bash
#TICK stack elements
sudo curl -sL https://repos.influxdata.com/influxdb.key | sudo apt-key add -
echo "deb https://repos.influxdata.com/debian buster stable" | sudo tee -a /etc/apt/sources.list
sudo apt-get update
sudo apt-get install telegraf -y
sudo usermod -G video telegraf
