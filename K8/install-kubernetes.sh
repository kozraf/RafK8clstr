#!/bin/bash

# Disable swap
echo -e "--------"
echo -e "----Disable swap----"
#sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
sudo sed -i '/swap/s/^/#/' /etc/fstab
sudo swapoff -a

# Install container.d
echo -e "--------"
echo -e "Install container.d"
sudo tee /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF
sudo modprobe overlay
sudo modprobe br_netfilter
sudo tee /etc/sysctl.d/kubernetes.conf <<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF
sudo sysctl --system

containerd config default | sudo tee /etc/containerd/config.toml >/dev/null 2>&1
sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml
sudo systemctl restart containerd
sudo systemctl enable containerd

# Install Kubernetes components
echo -e "--------"
echo -e "----Install Kubernetes components----"
sudo apt update
sudo apt install curl apt-transport-https  -y

# Below hashtagged is old approach pre 1.27 - https://forum.linuxfoundation.org/discussion/864693/the-repository-http-apt-kubernetes-io-kubernetes-xenial-release-does-not-have-a-release-file
#curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
#sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main" -y

echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

sudo apt update
sudo apt install -y kubeadm=1.28.7-1.1 kubelet=1.28.7-1.1 kubectl=1.28.7-1.1

sudo apt-mark hold kubelet kubeadm kubectl


