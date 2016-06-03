#!/bin/sh 

sudo mount -t cifs //pek-exit15/ISO-Images /home/myan/iso -o username=myan,password=xxxx,rw
sudo mount -t cifs //pek2-dbc302.eng.vmware.com/pek2-dbc302 /home/myan/dbc -o username=myan,password=xxxx,uid=myan,rw
