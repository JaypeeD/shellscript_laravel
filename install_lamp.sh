#!/bin/bash

#Install Apache2 Web Server, Lamp and MySQL Server

echo 'Installing Apache2 Web Server ...'
sudo apt-get install apache2;

sudo add-apt-repository ppa:ondrej/php;

echo 'Downloading package lists ...'
sudo apt-get update;

echo 'Installing Php ...'
sudo apt-get install php7.0 libapache2-mod-php7.0 php7.0-mbstring php7.0-xml;

echo 'Installing MySql Server ...'
sudo apt-get install mysql-server;
