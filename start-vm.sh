#!/bin/sh

image=$1
name=`date "+%Y-%m-%d-%H-%M-%S"`-$1

virt-install --import --name $name --ram 2048 --disk path=$image,format=raw --noautoconsole --network=default,model=e1000  --network=default,model=rtl8139 --network=default,model=e1000
