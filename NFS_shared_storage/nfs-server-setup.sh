#!/bin/bash

# Install NFS server on node1.local
sudo apt update
sudo apt install -y nfs-kernel-server

# Create export directory
sudo mkdir -p /srv/nfs
sudo chown nobody:nogroup /srv/nfs
sudo chmod 777 /srv/nfs

# Configure NFS exports so node2 and node3 can access it
echo '/srv/nfs/k8s_pv_jenkins 192.168.89.142(rw,sync,no_subtree_check) 192.168.89.143(rw,sync,no_subtree_check)' | sudo tee -a /etc/exports

# Restart NFS server and enable on boot
sudo systemctl restart nfs-kernel-server
sudo systemctl enable nfs-kernel-server

# Open necessary ports
sudo ufw allow from 192.168.89.0/24 to any port nfs
kubectl apply -f /home/vagrant/RafK8clstr/NFS_shared_storage/storageclass.yaml

