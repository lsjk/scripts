#!/bin/sh

#root     26924  0.0  0.0  17880   360 ?        S<s  14:01   0:00 ovsdb-server: monitoring pid 26925 (healthy)                                                                                                                                                                                                                                                                                                                                                        
#root     26925  0.1  0.0  18152  3668 ?        S<   14:01   0:00 ovsdb-server /etc/openvswitch/conf.db -vconsole:emer -vsyslog:err -vfile:info --remote=punix:/var/run/openvswitch/db.sock --private-key=db:Open_vSwitch,SSL,private_key --certificate=db:Open_vSwitch,SSL,certificate --bootstrap-ca-cert=db:Open_vSwitch,SSL,ca_cert --no-chdir --log-file=/var/log/openvswitch/ovsdb-server.log --pidfile=/var/run/openvswitch/ovsdb-server.pid --detach --monitor
#root     26934  0.0  0.0  22428  2116 ?        S<s  14:01   0:00 ovs-vswitchd: monitoring pid 26935 (healthy)                                                                                                                                                                                    
#root     26935  0.0  0.0  22752  8232 ?        S<L  14:01   0:00 ovs-vswitchd unix:/var/run/openvswitch/db.sock -vconsole:emer -vsyslog:err -vfile:info --mlockall --no-chdir --log-file=/var/log/openvswitch/ovs-vswitchd.log --pidfile=/var/run/openvswitch/ovs-vswitchd.pid --detach --monitor

prefix=/home/myan/bin/ovs/sbin

sudo modprobe openvswitch


sudo $prefix/ovsdb-server     --remote=punix:/home/myan/bin/ovs/var/run/openvswitch/db.sock \
                 --log-file=/home/myan/bin/ovs/var/log/openvswitch/ovs-dbserver.log\
                 --remote=db:Open_vSwitch,Open_vSwitch,manager_options \
                 --private-key=db:Open_vSwitch,SSL,private_key \
                 --certificate=db:Open_vSwitch,SSL,certificate \
                 --bootstrap-ca-cert=db:Open_vSwitch,SSL,ca_cert \
                 --pidfile --detach

#Only need to run this the first time.
ovs-vsctl --no-wait --db=unix:/home/myan/bin/ovs/var/run/openvswitch/db.sock init 

#Start vswitch
sudo $prefix/ovs-vswitchd --pidfile --detach --log-file=/home/myan/bin/ovs/var/log/openvswitch/ovs-vswitchd.log

#sudo chmod 755 /home/myan/bin/ovs/var/run/openvswitch/db.sock
