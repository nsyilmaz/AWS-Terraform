#!/bin/sh

sudo apt-get update
sudo apt-get install -y apache2


echo `cat /etc/hostname ` > /var/www/html/index.html


