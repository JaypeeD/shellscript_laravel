#!/bin/bash

#Install Composer (Composer is required for installing Laravel Dependencies)

echo 'Downloading Composer ...'
curl -sS https://getcomposer.org/installer | php;
sudo mv composer.phar /usr/local/bin/composer
sudo;
chmod +x /usr/local/bin/composer;
