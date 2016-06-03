#!/bin/bash

disk_image_dir=/home/myan/vm/vm_disk_templates
dest_image_dir=/home/myan/vm

function do_help {
	echo "Starting a default VM from disk templates store"
	echo "Usage:"
	echo "    start-with-template.sh <disk template name>"
}

if [ $# -lt 1 ];then
	echo "Missing argument"
	do_help
	exit 1
fi

vmname=$1-`date "+%Y-%m-%d-%H-%M-%S"`
startup=$dest_image_dir/$vmname/start.sh
echo "Creating VM $vmname"

#generate random mac address
randaddr=`od -An -N3 -t xC /dev/urandom | sed -e "s/ /-/g"`

function gen_scripts {
	touch $startup
	echo '#!/bin/bash' >> $startup
	echo 'set -e' >> $startup
	echo "macaddr=00-60-2f$randaddr" >> $startup
	echo "port=vport$randaddr">> $startup
	echo '#default bridge'>> $startup
	echo 'switch=br0'>> $startup
	echo 'function del_vport {'>> $startup
	echo '	echo "Cleaning vport $port"'>> $startup
	echo '	sudo ifconfig $port down'>> $startup
	echo '	sleep 0.1s'>> $startup
	echo '	ovs-vsctl del-port $switch $port'>> $startup
	echo '	sleep 0.1s'>> $startup
	echo '	sudo ip tuntap del mode tap $port'>> $startup
	echo '	echo "Done"'>> $startup
	echo '}'>> $startup

	echo 'function add_vport {'>> $startup
	echo '	echo "Adding vport $port"'>> $startup
	echo '	sudo ip tuntap add mode tap $port'>> $startup
	echo '	sleep 0.1s'>> $startup
	echo '	ovs-vsctl add-port $switch $port'>> $startup
	echo '	sleep 0.1s'>> $startup
	echo '	sudo ifconfig $port up'>> $startup
	echo '	echo "Done"'>> $startup
	echo '}'>> $startup
	echo '# clean up when the VM got killed'>> $startup
	echo 'trap del_vport EXIT'>> $startup
	echo '# setup the vport before starting qemu'>> $startup
	echo 'add_vport'>> $startup
	echo "diskimage=$dest_image_dir/$vmname/$1" >> $startup
	echo 'qemu-system-x86_64 -machine pc,accel=kvm,usb=off -cpu host -m 2048 -realtime mlock=off -smp 2,sockets=2,cores=1,threads=1 -rtc base=utc -no-shutdown -net tap,ifname=$port,script=no -boot d -net nic,model=virtio,macaddr=$macaddr --nographic -drive if=none,id=aa-disk0,format=raw,file=$diskimage -device virtio-blk-pci,drive=aa-disk0  -vnc :3'>> $startup

	chmod a+x $startup
}

# setup disk-image
if [ -f "$disk_image_dir/$1" ];then
	mkdir $dest_image_dir/$vmname
	echo "Copying VM disk image to $dest_image_dir/$vmname"
	cp $disk_image_dir/$1 $dest_image_dir/$vmname/$1
	echo "Generating start-up scripts"
	gen_scripts $1
	echo "VM $vmname created in $dest_image_dir/$vmname"
else
	echo "VM template $1 not found"
	exit 1
fi
