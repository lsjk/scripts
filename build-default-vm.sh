#!/bin/sh

os=$1

#/home/myan/work/libguestfs/run virt-builder $os --size 20G -x -v --root-password password:123456 --firstboot-command 'useradd -m -p "" myan; chage -d 0 myan; usermod -aG sudo myan;'

virt-builder $os --size 20G -x -v --root-password password:123456 --firstboot-command 'useradd -m -p "" myan; chage -d 0 myan; usermod -aG sudo myan;'
