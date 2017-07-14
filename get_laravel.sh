#!/bin/bash

CHECK_DIRECTORY = "/var/www/html"
LARAVEL_FOLDER_NAME=

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
   
   if [ -z "$(LARAVEL_FOLDER_NAME)" ]; then
	LARAVEL_FOLDER_NAME=${laravelInput}
   else
        echo "NOT EMPTY!"
   fi    

   #Set proper permissions on files
   sudo chown -R www-data:www-data ${CHECK_DIRECTORY}'/'${laravelInput};
   sudo chmod -R 755 ${CHECK_DIRECTORY};
   sudo chmod -R 777 ${CHECK_DIRECTORY}'/storage';
}

function setEncryptionKey {
   cd ${CHECK_DIRECTORY}'/'${LARAVEL_FOLDER_NAME}<<EOF

	sudo composer install

   EOF
}

#Install Git and clone master repo of laravel from gitlab

echo 'Installing Git ...'
sudo apt-get install git;

#Check if the directory is empty

if [ "$(ls -A ${CHECK_DIRECTORY})" ]; then
   for i in $(ls -l ${CHECK_DIRECTORY})
      do
	sudo chown -R triune:triune ${i};
	sudo rm -r ${i};
      done
   installLaravel
   setPermissions
   setEncryptionKey  
  
else
   installLaravel
   setPermissions 
   setEncryptionKey 

fi



