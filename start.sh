#!/bin/sh

macaddr=`echo '00 60 2f'$(od -An -N3 -t xC /dev/urandom) | sed -e 's/ /:/g'`

echo $macaddr

qemu-system-x86_64 -machine pc,accel=kvm,usb=off -cpu host -m 4906 -realtime mlock=off -smp 4,sockets=4,cores=1,threads=1 -rtc base=utc -no-shutdown -net tap,ifname=vport3,script=no -net nic,model=virtio,macaddr=$macaddr -boot c -drive file=/home/myan/iso/OS/Other/Windows/Windows7/Ent/SW_DVD5_SA_Win_Ent_7w_SP1_64BIT_English_-2_MLF_X17-58882.ISO,index=1,media=cdrom -drive file=/home/myan/vm/win7/virtio-win-0.1.102.iso,index=2,media=cdrom -drive file=/home/myan/vm/win7/SW_DVD5_Office_Professional_Plus_2016_64Bit_English_MLF_X20-42432.ISO,index=3,media=cdrom -drive if=none,id=aa-disk0,format=raw,file=./win7-disk.img -device virtio-blk-pci,drive=aa-disk0 -device virtio-balloon -vga qxl -spice port=5924,disable-ticketing -device virtio-serial-pci -device virtserialport,chardev=spicechannel0,name=com.redhat.spice.0 -chardev spicevmc,id=spicechannel0,name=vdagent

