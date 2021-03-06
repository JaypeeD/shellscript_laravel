#!/bin/bash

CHECK_DIRECTORY="/var/www/html"

function installLaravel {
   cd /var/www/html;
   echo 'Enter Branch to Checkout: '
   read branchInput

   echo 'Enter GitLab HTTP Link: '
   read httpInput

   git clone -b ${branchInput} ${httpInput} .

}

function setPermissions {
   echo 'Enter Laravel Folder Name: '
   read laravelInput 

   #Set proper permissions on files
   sudo chown -R www-data:www-data ${CHECK_DIRECTORY}'/'${laravelInput};
   sudo chmod -R 755 ${CHECK_DIRECTORY};
   sudo chmod -R 777 ${CHECK_DIRECTORY}'/'${laravelInput}'/storage';
   
   echo 'Setting Encryption Key'
   cd ${CHECK_DIRECTORY}'/EWS_laravel'
   sudo php artisan key:generate
}

function installComposer {
   cd ${CHECK_DIRECTORY}'/EWS_laravel'

   sudo composer install
}

#Install Git and clone master repo of laravel from gitlab

echo 'Installing Git ...'
sudo apt-get install git;

#Check if the directory is empty
if [ "$(ls -A ${CHECK_DIRECTORY})" ]; then
   for i in $(ls ${CHECK_DIRECTORY})
      do
	sudo chown -R triune:triune ${CHECK_DIRECTORY}'/'${i};
	sudo rm -r ${CHECK_DIRECTORY}'/'${i};
      done
   installLaravel
   installComposer
   setPermissions  
  
else
   installLaravel
   installComposer 
   setPermissions 
fi
