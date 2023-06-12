#!/bin/bash

echo -e "--------"
echo -e "Install NFS client on node2 and node3"

sudo apt update
sudo apt install -y nfs-common

echo -e "--------"
echo -e "Create mount point"

sudo mkdir -p /mnt/nfs

echo -e "--------"
echo -e "Mount NFS share"

sudo mount 192.168.89.141:/srv/nfs /mnt/nfs

echo -e "--------"
echo -e "Add NFS share to /etc/fstab"

echo "192.168.89.141:/srv/nfs /mnt/nfs nfs defaults 0 0" | sudo tee -a /etc/fstab
