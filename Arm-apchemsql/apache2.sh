#!/bin/bash

# Bash script to install Vert.x, OpenJDK 7, Apache and MySQL Server

# Set MySQL Server password
mysql_password="Passw0rd!"

# Set MySQL Server version to install
mysql_version="5.6"


# Install  OpenJDK 7, and Apache
sudo apt-get -y update
sudo apt-get install unzip -y
sudo apt-get install openjdk-8-jdk -y
sudo apt-get install apache2 libapache2-mod-passenger -y

sudo apt-get install redmine redmine-mysql


# Install MySQL Server in non-interactive mode
export DEBIAN_FRONTEND=noninteractive
echo "mysql-server-$mysql_version mysql-server/root_password password $mysql_password" | debconf-set-selections
echo "mysql-server-$mysql_version mysql-server/root_password_again password $mysql_password" | debconf-set-selections
apt-get install mysql-server -y

# restart Apache
/etc/init.d/apache2 restart

# Edit crontab to start MySQL Server service automatically on boot
(crontab -l 2>/dev/null; echo "@reboot service mysql start") | crontab -