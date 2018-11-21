#!/bin/bash
echo "Update and upgrade"
echo "deb https://repos.influxdata.com/debian stretch stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
sudo apt-get update
sudo apt-get upgrade -y
echo "Install basic stuff"
sudo apt-get install wget git curl vim dtrx screen htop nload fortunes build-essential python python3 -y
echo "Install domoticz"
curl -L install.domoticz.com | sudo bash
echo "Install influxdb"
sudo apt-get install influxdb -y
echo "Warning - installing grafana 5.0.3 - check for latest version"
curl -LO https://github.com/fg2it/grafana-on-raspberry/releases/download/v5.0.3/grafana_5.0.3_armhf.deb
sudo dpkg -i grafana_5.0.3_armhf.deb
echo "Install xbindkeys, transmission, LAMP"
sudo apt-get install xbindkeys xbindkeys-config -y
sudo apt-get install apache2 mysql-server php7.0-mysql -y 
sudo apt-get install transmission-daemon transmission-remote-gtk transmission-cli -y
sudo apt-get install webfs motion -y
echo "cloning scrpits"
git clone https://github.com/lordofda/rpiscripts
git clone https://github.com/tremc/tremc
cd tremc
sudo make install
cd ..
