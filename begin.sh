#!/bin/bash
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get rpi-update
sudo apt-get install wget git curl vim dtrx screen htop nload fortunes build-essential python python3 -y
curl https://get.pimoroni.com/uptodate | bash
//curl -sLS https://apt.adafruit.com/add | sudo bash
