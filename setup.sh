#!/bin/bash

# Initialize variables for menu selection
basicK8=0
k8Metrics=0
k8Dashboard=0
jenkins=0
argoCD=0
destroy=0
suspend=0

# Function to display menu
display_menu() {
  clear
  echo "Please select which scripts to uncomment:"
  echo "[$basicK8] 1. Basic K8"
  echo "[$k8Metrics] 2. k8-metrics-server"
  echo "[$k8Dashboard] 3. K8-dashboard"
  echo "[$jenkins] 4. Jenkins_with_TF"
  echo "[$argoCD] 5. ArgoCD"
  echo "[$suspend] 6. Suspend all VMs"
  echo "[$destroy] 0. Destroy all VMs"
  echo "7. Continue with provisioning"
  echo "8. Exit"
}

# Main loop for menu selection
while true; do
  display_menu
  read -p "Enter your choice: " choice
  
  case $choice in
    1) basicK8=$((1 - $basicK8));;
    2) k8Metrics=$((1 - $k8Metrics));;
    3) k8Dashboard=$((1 - $k8Dashboard));;
    4) jenkins=$((1 - $jenkins));;
    5) argoCD=$((1 - $argoCD));;
    6) suspend=$((1 - $suspend));;
    0) destroy=$((1 - $destroy));;
    7) 
      echo "Continuing with provisioning..."

if [ "$basicK8" -eq 1 ]; then
  echo "Provisioning Basic K8..."
  cp Vagrantfile1 Vagrantfile
  echo Running "'vagrant up --color'..."
  vagrant up --color
	basicK8=0
	echo "K8 3-node cluster has been installed!"
fi

if [ "$k8Metrics" -eq 1 ]; then
  echo "Provisioning K8-metrics-serve..."
  cp Vagrantfile2 Vagrantfile
  echo Running "'vagrant up --color'..."
  vagrant provision node1 --provision-with K8-metrics-server_perms,K8-metrics-server_ownership,K8-metrics-server_install --color
	k8Metrics=0
	echo "K8-metrics-server has been installed!"
fi

if [ "$k8Dashboard" -eq 1 ]; then
  echo "Provisioning K8-Dashboard..."
  cp Vagrantfile2 Vagrantfile
  echo Running "'vagrant up --color'..."
  vagrant provision node1 --provision-with K8-dashboard_git-clone,K8-dashboard_perms,K8-dashboard_ownership,K8-dashboard_install --color
	k8Dashboard=0
	echo "K8-Dashboard has been installed!"
fi

if [ "jenkins" -eq 1 ]; then
  echo "Provisioning Jenkins_with_TF..."
  cp Vagrantfile2 Vagrantfile
  echo Running "'vagrant up --color'..."
  vagrant provision node1 --provision-with Jenkins-with-TF_git-clone,Jenkins-with-TF_perms,Jenkins-with-TF_ownership,Jenkins-with-TF_install --color
	jenkins=0
	echo "Jenkins_with_TF has been installed!"
fi

if [ "argoCD" -eq 1 ]; then
  echo "Provisioning ArgoCD..."
  cp Vagrantfile2 Vagrantfile
  echo Running "'vagrant up --color'..."
  vagrant provision node1 --provision-with ArgoCD_git-clone,ArgoCD_perms,ArgoCD_ownership,ArgoCD_install --color
	argoCD=0
	echo "ArgoCD has been installed!"
fi

if [ "suspend" -eq 1 ]; then
  echo "Suspend all VM's..."
  cp Vagrantfile2 Vagrantfile
  echo Running "'vagrant suspend'..."
  vagrant suspend
	suspend=0
	echo "ArgoCD has been installed!"
fi

if [ "destroy" -eq 1 ]; then
  echo "Destroying!!!"
  cp Vagrantfile1 Vagrantfile
  echo Running "'vagrant destroy -f'..."
  echo Running 'vagrant destroy -f'...
	basicK8=0
  k8Metrics=0
  k8Dashboard=0
  jenkins=0
  argoCD=0
  suspend=0
  destroy=0
	echo "All VMs have been removed"
fi

      ;;
    8) 
      echo "Exiting..."
      exit 0
      ;;
    *)
      echo "Invalid choice"
      ;;
  esac
done
