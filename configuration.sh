#!/bin/bash

function createVirtualHost {
echo 'Enter Config Name: '
read confignameInput


sudo su<<EOF
  CONFIG_FILE="/etc/apache2/sites-available/"${confignameInput}".conf"
  if [ ! -e "${CONFIG_FILE}" ]; then
    echo "
    <VirtualHost *:80>
    	  ServerName ews.dev.com
          DocumentRoot /var/www/html/EWS_laravel/public
          <Directory /var/www/html/EWS_laravel>
                  AllowOverride All
          </Directory>
          ErrorLog ${APACHE_LOG_DIR}/error.log
          LogLevel warn
          CustomLog ${APACHE_LOG_DIR}/access.log combined
    </VirtualHost>" > ${CONFIG_FILE}
    echo -e $"\nNew Virtual Host Created\n"
    
     sudo a2ensite ${confignameInput};
     sudo a2dissite 000-default.conf;
     sudo service apache2 reload;
  else
     echo "File already exists."
     sudo a2ensite ${confignameInput};
     sudo a2dissite 000-default.conf;
     sudo service apache2 reload;
  fi
EOF
}

function launchServiceFIle_14 {

sudo apt-get install -y nodejs;
sudo apt-get install -y nodejs-legacy;

echo 'Enter Service Name: '
read serviceNameInput

sudo su<<EOF
SERVICE_FILE="/etc/systemd/system/"${serviceNameInput}".service"
if [ ! -e "${SERVICE_FILE}" ]; then
    echo 'Service file is not configured.. Creating a new Service File'
    echo "[Unit]
              Description= TCP/IP & Websocket Server Service File
              Documentation= JaypeeD
              After=network.target
              [Service]
              Type=simple
              User=triune
              ExecStart=/usr/bin/node /var/www/html/nodejs/NodeJSProject1/TCPserver.js
                          Restart=on-failure
              [Install]
              WantedBy=multi-user.target" > ${SERVICE_FILE}

	     sudo systemctl daemon-reload
             echo "Creating Socket Server"
  else
     echo "File already exists."
  fi
EOF
}
function launchServiceFIle_16 {

sudo apt-get install -y nodejs;
sudo apt-get install -y nodejs-legacy;

echo 'Enter Service Name: '
read serviceNameInput

sudo su<<EOF
SERVICE_FILE="/lib/systemd/system/"${serviceNameInput}".service"
if [ ! -e "${SERVICE_FILE}" ]; then
    echo 'Service file is not configured.. Creating a new Service File'
    echo "[Unit]
              Description= TCP/IP & Websocket Server Service File
              Documentation= JaypeeD
              After=network.target
              [Service]
              Type=simple
              User=triune
              ExecStart=/usr/bin/node /var/www/html/nodejs/NodeJSProject1/TCPserver.js
                          Restart=on-failure
              [Install]
              WantedBy=multi-user.target" > ${SERVICE_FILE}
	     sudo systemctl daemon-reload
             echo "Creating Socket Server"
  else
     echo "File already exists."
  fi
EOF
}
function chooseVersion {
echo "*************************************"
echo "*                                   *" 
echo "* [1] Service File for Ubuntu 14.04 *"
echo "*                                   *"
echo "* [2] Service File for Ubuntu 16.04 *"
echo "*                                   *"
echo "*************************************"
read serviceChosen

case ${serviceChosen} in
	"1") launchServiceFile_14 ;;
        "2") launchServiceFile_16 ;;

esac

}

sudo apt-get install -y php7.0-mysql;
createVirtualHost
chooseVersion 


