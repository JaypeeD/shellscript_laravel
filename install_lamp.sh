#!/bin/bash

#Install Apache2 Web Server, Lamp and MySQL Server
echo 'Downloading package lists ...'
sudo apt-get update;

echo 'Installing Apache2 Web Server ...'
sudo apt-get install apache2;

echo 'Installing Php ...'
sudo apt-get-repository ppa:ondrej/php;
sudo apt-get install php7.0 libapache2-mod-php7.0 php7.0-mbstring php7.0-xml;

echo 'Installing MySql Server ...'
sudo apt-get install mysql-server;