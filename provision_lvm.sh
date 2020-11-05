#!/bin/sh

# create physical volume
yum -y install lvm2
sudo pvcreate /dev/sdb
sudo pvscan
# create vg group
sudo vgcreate dockerVG /dev/sdb
sudo vgscan
# create logical volume and create file system
sudo lvcreate --size 10GB --name lv_docker dockerVG
sudo lvscan
sudo mkfs.ext4 /dev/mapper/lv_docker 
# create dir and mount fs
sudo mkdir -pv /docker
sudo mount /dev/mapper/lv_docker /docker

# restart new 
#restart