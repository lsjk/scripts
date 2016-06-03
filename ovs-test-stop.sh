#!/bin/sh

ovs_path=/home/myan/ovs/_build-gcc/utilities

sudo ifconfig vport1 down
sudo ifconfig vport2 down
sudo ifconfig vport3 down

$ovs_path/ovs-vsctl del-port br0 vport1
$ovs_path/ovs-vsctl del-port br0 vport2
$ovs_path/ovs-vsctl del-port br0 vport3

$ovs_path/ovs-vsctl del-port enp65s0f0

sudo $ovs_path/ovs-dpctl del-dp ovs-system

$ovs_path/ovs-vsctl del-br br0
