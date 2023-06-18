#!/bin/bash

echo -e "--------"
echo -e "Install NFS server on node1.local"

sudo apt update
sudo apt install -y nfs-kernel-server


echo -e "--------"
echo -e "Create export directory"
sudo mkdir -p /srv/nfs
sudo chown nobody:nogroup /srv/nfs
sudo chmod 777 /srv/nfs

echo -e "--------"
echo -e "Configure NFS exports so node2 and node3 can access it"
#
sudo echo '/srv/nfs/k8s 192.168.89.142(rw,sync,no_subtree_check) 192.168.89.143(rw,sync,no_subtree_check)' | sudo tee -a /etc/exports

echo -e "--------"
echo -e "Restart NFS server and enable on boot"

sudo systemctl restart nfs-kernel-server
sudo systemctl enable nfs-kernel-server

echo -e "--------"
echo -e "Open necessary ports"

sudo ufw allow from 192.168.89.0/24 to any port nfs

echo -e "--------"
echo -e "Adding storageclass"

sudo tee /home/vagrant/K8/storageclass.yaml <<EOF
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: nfs-storage
provisioner: kubernetes.io/no-provisioner
mountOptions:
  - hard
  - nfsvers=4.1
EOF

sudo kubectl apply -f /home/vagrant/K8/storageclass.yaml

