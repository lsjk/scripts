#!/bin/sh

#macaddr1=`echo '00 60 2f'$(od -An -N3 -t xC /dev/urandom) | sed -e 's/ /:/g'`
#macaddr2=`echo '00 60 2f'$(od -An -N3 -t xC /dev/urandom) | sed -e 's/ /:/g'`

macaddr1=00:60:2f:69:d1:b1
macaddr2=00:60:2f:5f:50:12

echo $macaddr1
echo $macaddr2

qemu-system-x86_64 -machine pc,accel=kvm,usb=off -cpu SandyBridge,+vmx -m 4096 -realtime mlock=off -smp 4,sockets=4,cores=1,threads=1 -rtc base=utc -no-shutdown -net tap,ifname=vport1,script=no -boot c -cdrom $1 -net nic,model=e1000,macaddr=$macaddr1 -net nic,model=e1000,macaddr=$macaddr2 -vnc :1 -monitor telnet:127.0.0.1:1234,server,nowait --nographic

#qemu-system-x86_64 -machine pc,accel=kvm,usb=off -cpu host -m 4096 -realtime mlock=off -smp 4,sockets=4,cores=1,threads=1 -rtc base=utc -no-shutdown -boot n -net user,tftp=/home/myan/pxe-esx/,bootfile=gpxelinux.0,hostfwd=tcp::8192-:22 -option-rom pxe-virtio.rom -net nic,model=virtio -net nic,model=e1000 -net nic,model=e1000 -vnc :1 -monitor telnet:127.0.0.1:1234,server,nowait

#qemu-system-x86_64 -machine pc,accel=kvm,usb=off -cpu SandyBridge,+pdpe1gb,+osxsave,+dca,+pcid,+pdcm,+xtpr,+tm2,+est,+smx,+vmx,+ds_cpl,+monitor,+dtes64,+pbe,+tm,+ht,+ss,+acpi,+ds,+vme -m 4096 -realtime mlock=off -smp 4,sockets=4,cores=1,threads=1 -rtc base=utc -no-shutdown -boot n -net user,tftp=/home/myan/pxe-esx/,bootfile=gpxelinux.0,hostfwd=tcp::2222-:22 -option-rom pxe-virtio.rom -net nic,model=virtio -net nic,model=e1000 -net nic,model=e1000 -vnc :1 -monitor telnet:127.0.0.1:1234,server,nowait


#qemu-system-x86_64 -machine pc-i440fx-2.4,accel=kvm,usb=off -cpu SandyBridge,+pdpe1gb,+osxsave,+dca,+pcid,+pdcm,+xtpr,+tm2,+est,+smx,+vmx,+ds_cpl,+monitor,+dtes64,+pbe,+tm,+ht,+ss,+acpi,+ds,+vme -m 4096 -realtime mlock=off -smp 4,sockets=4,cores=1,threads=1 -rtc base=utc -no-shutdown -boot n -net user,tftp=/home/myan/pxe-esx/,bootfile=gpxelinux.0,hostfwd=tcp::2222-:22 -option-rom pxe-e1000.rom  -net nic,model=e1000 -vnc :1
