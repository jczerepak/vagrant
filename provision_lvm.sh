#!/bin/sh

# create physical volume
sudo yum -y install lvm2
sudo pvcreate /dev/sdb
sudo pvcreate /dev/sdc
sudo pvscan

# create vg group
sudo vgcreate dockerVG /dev/sdb
sudo vgcreate dataVG /dev/sdc
sudo vgscan

# create logical volume and create file system
sudo lvcreate --size 10GB --name lv_docker dockerVG
sudo lvcreate --size 1GB --name lv_data dataVG
sudo lvscan
sudo mkfs.ext4 /dev/dockerVG/lv_docker
sudo mkfs.ext4 /dev/dataVG/lv_data

# create dir and mount fs
sudo mkdir -pv /mnt/data
sudo chown vagrant. -R /mnt/data
sudo mount /dev/mapper/dataVG-lv_data /mnt/data
sudo mount /dev/mapper/dockerVG-lv_docker /var/lib/docker
