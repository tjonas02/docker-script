#!/bin/bash

#This script install Docker on Linux, Centos7..
#Author:Alex
#Date: Mars, 06/2022.

echo "\n Let check your login privileges for this action\n"
if [ $UID -eq 0 ]
	then
echo
	echo "\n Great!!!! you are root, let start docker installation process....\n"
else
echo
	echo "\n Please, this action requires root privileges... could not continue!\n"
	exit 1
fi
echo
echo "\n Let cleanup your Server, Uninstall old versions, this may take couple of seconds....\n"

 sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine
if [ $? -ne 0 ]
then 
	echo "\n Issue with the cleanup (Uninstall old versions)\n"
	exit 2
fi
echo 
echo "\n Set up the docker repository.....\n"

sudo yum install -y yum-utils
 sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo -y
if [ $? -ne 0 ]
then 
	echo "\n Issue Set up the docker repository\n"
	exit 3
fi

echo
echo "\n Now Let Install Docker Engine.....\n"

sudo yum install docker-ce docker-ce-cli containerd.io -y
if [ $? -ne 0 ]
then 
	echo "\n Issue Installing Docker Engine\n"
	exit 4
fi
echo
echo "\n Let start, enable and check status of Docker.....\n"
echo
sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl status docker
yum install net-tools-y

echo "\Let Verify that Docker Engine is installed correctly by running the hello-world image:  \n"
echo
sudo docker run hello-world
if [ $? -ne 0 ]
then 
	echo "\n Issue Installing Docker Engine, connexion check failed\n"
	exit 5
fi

ifconfig | grep 192.
echo
echo "\n Congratulations!!!! your Docker engine Was succesfully installed and Hello-Word checked..see above your server IP adress .....\n"








