#!/bin/sh

yum -y install git;
yum -y remove java;
yum -y install java-1.7.0-openjdk;
yum -y install libguestfs-tools;
yum -y install libvirt;
yum -y groupinstall 'Development Tools'
