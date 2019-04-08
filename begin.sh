#!/bin/bash
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get rpi-update
sudo apt-get install wget git curl vim dtrx screen htop nload ncdu fortunes build-essential python python3 -y
curl https://get.pimoroni.com/uptodate | bash
//curl -sLS https://apt.adafruit.com/add | sudo bash
sudo curl -sL https://repos.influxdata.com/influxdb.key | sudo apt-key add - && echo "deb https://repos.influxdata.com/debian jessie stable" | tee -a /etc/apt/sources.list
sudo apt-get install telegraf -y
