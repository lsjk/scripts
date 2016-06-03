#!/bin/sh

#install and configure mysql
mysql_conf=/etc/my.cnf

yum -y install mariadb mariadb-server MySQL-python

echo "[mysqld]" >> $mysql_conf
echo "bind-address = 10.0.0.11" >> $mysql_conf
echo "default-storage-engine = innodb" >> $mysql_conf
echo "innodb_file_per_table" >> $mysql_conf
echo "collation-server = utf8_general_ci" >> $mysql_conf
echo "init-connect = 'SET NAMES utf8'" >> $mysql_conf
echo "character-set-server = utf8" >> $mysql_conf

systemctl enable mariadb.service
systemctl start mariadb.service

#do this on shell 
# mysql -u root mysql
# $mysql> UPDATE user SET Password=PASSWORD('123456') where USER='root';
# $mysql> FLUSH PRIVILEGES;
# 
# systemctl restart mariadb.service

#install erlang
yum -y install epel-release
wget https://packages.erlang-solutions.com/erlang-solutions-1.0-1.noarch.rpm
rpm -Uvh erlang-solutions-1.0-1.noarch.rpm
yum -y install erlang

#install rabbitmq
wget https://www.rabbitmq.com/releases/rabbitmq-server/v3.6.2/rabbitmq-server-3.6.2-1.noarch.rpm
rpm --import https://www.rabbitmq.com/rabbitmq-release-signing-key.asc
yum -y install rabbitmq-server-3.6.2-1.noarch.rpm

### Erland and EPMD ports (if RabbitMQ cluster is used)
firewall-cmd --permanent --add-port=4369/tcp
firewall-cmd --permanent --add-port=25672/tcp

### The RabbitMQ default port (the one you gave)
firewall-cmd --permanent --add-port=5672/tcp

### The RabbitMQ SSL default port (if SSL is used)
firewall-cmd --permanent --add-port=5671/tcp

### The RabbitMQ management plugin (if enable)
firewall-cmd --permanent --add-port=15672/tcp
firewall-cmd --reload
setsebool -P nis_enabled 1

systemctl enable rabbitmq-server.service
systemctl start rabbitmq-server.service

rabbitmqctl change_password guest 123456

# install openstack 
yum -y install centos-release-openstack-mitaka
yum -y install https://rdoproject.org/repos/rdo-release.rpm
yum -y install python-openstackclient
