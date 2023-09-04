@echo off
setlocal enabledelayedexpansion

REM Initialize variables for menu selection
set basicK8=0
set k8Metrics=0
set k8Dashboard=0
set jenkins=0
set argoCD=0
set destroy=0

cls

:menu
cls
echo Please select which scripts to uncomment:
echo [!basicK8!] 1. Basic K8
echo [!k8Metrics!] 2. k8-metrics-server
echo [!k8Dashboard!] 3. K8-dashboard
echo [!jenkins!] 4. Jenkins_with_TF
echo [!argoCD!] 5. ArgoCD
echo [!destroy!] 0. Destroy all VMs
echo 7. Continue with provisioning
echo 8. Exit

set /p choice=Enter your choice: 

if "!choice!"=="1" (
    set basicK8=1
    goto menu
)

if "!choice!"=="2" (
    set k8Metrics=1
    goto menu
)

if "!choice!"=="3" (
    set k8Dashboard=1
    goto menu
)

if "!choice!"=="4" (
    set jenkins=1
    goto menu
)

if "!choice!"=="5" (
    set ArgoCD=1
    goto menu
)

if "!choice!"=="0" (
    set destroy=1
    goto menu
)

if "!choice!"=="7" (
    REM Here you would insert the commands to actually perform the provisioning based on the selected options
    REM For example:
    REM if "!basicK8!"=="1" (
    REM     REM Perform basic K8 provisioning
    REM )
    REM ...
	
	if "!basicK8!"=="1" (
	echo Copying Vagrantfile1 to Vagrantfile...
    copy /y Vagrantfile1 Vagrantfile
    echo Running 'vagrant up --color'...
    vagrant up --color
	set basicK8=0
	echo K8 3-node cluster has been installed!
	)

	if "!k8Metrics!"=="1" (
    
	echo Copying Vagrantfile1 to Vagrantfile...
    copy /y Vagrantfile2 Vagrantfile
    echo Running 'vagrant provision node1 --provision-with K8-metrics-server_perms,K8-metrics-server_ownership,K8-metrics-server_install --color'...
    vagrant provision node1 --provision-with K8-metrics-server_perms,K8-metrics-server_ownership,K8-metrics-server_install --color
	echo k8-metrics-server has been installed!
	)

	if "!k8Dashboard!"=="1" (
    
	echo Copying Vagrantfile1 to Vagrantfile...
    copy /y Vagrantfile2 Vagrantfile
    echo Running 'vagrant provision node1 --provision-with K8-dashboard_git-clone,K8-dashboard_perms,K8-dashboard_ownership,K8-dashboard_install --color'...
    vagrant provision node1 --provision-with K8-dashboard_git-clone,K8-dashboard_perms,K8-dashboard_ownership,K8-dashboard_install --color
	echo K8-dashboard has been installed!
	)
	
	if "!jenkins!"=="1" (
    
	echo Copying Vagrantfile1 to Vagrantfile...
    copy /y Vagrantfile2 Vagrantfile
    echo Running 'vagrant provision node1 --provision-with Jenkins-with-TF_git-clone,Jenkins-with-TF_perms,Jenkins-with-TF_ownership,Jenkins-with-TF_install --color'...
    vagrant provision node1 --provision-with Jenkins-with-TF_git-clone,Jenkins-with-TF_perms,Jenkins-with-TF_ownership,Jenkins-with-TF_install --color
	echo Jenkins_with_TF has been installed!
	)
	
	if "!argoCD!"=="1" (
    
	echo Copying Vagrantfile1 to Vagrantfile...
    copy /y Vagrantfile2 Vagrantfile
    echo Running 'vagrant provision node1 --provision-with ArgoCD_git-clone,ArgoCD_perms,ArgoCD_ownership,ArgoCD_install --color'...
    vagrant provision node1 --provision-with ArgoCD_git-clone,ArgoCD_perms,ArgoCD_ownership,ArgoCD_install --color
	echo ArgoCD_with_TF has been installed!
	)

	if "!destroy!"=="1" (
    
    echo Copying Vagrantfile1 to Vagrantfile...
    copy /y Vagrantfile1 Vagrantfile
    echo Running 'vagrant destroy -f'...
    vagrant destroy -f
	set basicK8=0
    set k8Metrics=0
    set k8Dashboard=0
    set jenkins=0
    set argoCD=0
    set all=0
    set destroy=0
	echo K8 3-node cluster has been destroyed!
	)
	
	if "!choice!"=="8" (
    set basicK8=0
    set k8Metrics=0
    set k8Dashboard=0
    set jenkins=0
    set argoCD=0
    set all=0
    set destroy=0
	exit
	goto :eof
	)
	
	REM Reset variables
    set basicK8=0
    set k8Metrics=0
    set k8Dashboard=0
    set jenkins=0
    set argoCD=0
    set all=0
    set destroy=0
   
)

if "!choice!"=="8" (
    set basicK8=0
    set k8Metrics=0
    set k8Dashboard=0
    set jenkins=0
    set argoCD=0
    set all=0
    set destroy=0
	exit
)
endlocal