#!/bin/sh

ovs_path=/home/myan/ovs/_build-gcc/utilities

$ovs_path/ovs-vsctl add-br br0

sudo ifconfig enp65s0f0 0
$ovs_path/ovs-vsctl add-port br0 enp65s0f0
sudo dhclient br0

sudo ifconfig vport1 up
sudo ifconfig vport2 up
sudo ifconfig vport3 up

$ovs_path/ovs-vsctl add-port br0 vport1
$ovs_path/ovs-vsctl add-port br0 vport2
$ovs_path/ovs-vsctl add-port br0 vport3
