#!/bin/sh

# install git
yum -y install git

# install dev packages
yum -y groupinstall 'Development Tools'

# remove old java installation if any
yum -y remove java

# install SUN compatible java environment
yum -y install java-1.7.0-openjdk

# install jenkins
yum -y install wget
wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
yum -y install jenkins

# disable firewall
firewall-cmd --zone=public --add-port=8080/tcp --permanent
firewall-cmd --zone=public --add-service=http --permanent
firewall-cmd --reload

# install uboot-tools
wget https://kojipkgs.fedoraproject.org/packages/uboot-tools/2011.03/1.el6/src/uboot-tools-2011.03-1.el6.src.rpm
rpmbuild --rebuild uboot-tools-2011.03-1.el6.src.rpm 
rpm -ivh /root/rpmbuild/RPMS/x86_64/uboot-tools-2011.03-1.el7.centos.x86_64.rpm

# install device tree compiler
wget https://kojipkgs.fedoraproject.org/packages/dtc/1.4.1/5.fc24/src/dtc-1.4.1-5.fc24.src.rpm 
rpmbuild --rebuild dtc-1.4.1-5.fc24.src.rpm 
rpm -ivh /root/rpmbuild/RPMS/x86_64/dtc-1.4.1-5.el7.centos.x86_64.rpm

