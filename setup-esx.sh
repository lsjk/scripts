#!/bin/sh

rmmod kvm_intel
rmmod kvm

#modprobe pci_stub
#
#echo "8086 105e" > /sys/bus/pci/drivers/pci-stub/new_id
#echo 0000:08:00.0 > /sys/bus/pci/devices/0000:08:00.0/driver/unbind
#echo 0000:08:00.1 > /sys/bus/pci/devices/0000:08:00.1/driver/unbind
#echo 0000:08:00.0 > /sys/bus/pci/drivers/pci-stub/bind
#echo 0000:08:00.1 > /sys/bus/pci/drivers/pci-stub/bind

modprobe kvm ignore_msrs=y
modprobe kvm_intel

#insmod /home/myan/work/linux-4.2.0/arch/x86/kvm/kvm-intel.ko
#insmod /home/myan/work/linux-4.2.0/arch/x86/kvm/kvm.ko ignore_msrs=y

