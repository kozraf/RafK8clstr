@echo off
setlocal enabledelayedexpansion

REM Initialize variables for menu selection
set basicK8=0
set k8Metrics=0
set k8Dashboard=0
set jenkins=0
set argoCD=0
set grafanaprometheus=0
set destroy=0
set suspend=0
set all=0
set resume=0

cls

:menu
cls
echo RafK8clstr DEPLOYMENT MENU
echo ---------------------------------------------------------------------------------
echo Choose if you would like to deploy only K8 3-node cluster (1) and/or add additional tools and press Enter:
echo [!basicK8!] 1. Basic K8
echo [!k8Metrics!] 2. k8-metrics-server
echo [!k8Dashboard!] 3. K8-dashboard
echo [!jenkins!] 4. Jenkins_with_TF
echo [!argoCD!] 5. ArgoCD
echo [!grafanaprometheus!] 6. Grafana / Prometheus
echo [!all!] 7. Basic K8 + K8-metrics-server + K8-dashboard + Jenkins_with_TF + ArgoCD
echo ---------------------------------------------------------------------------------
echo Now choose from below and then choose C to continue or Q to quit:
echo [!suspend!] 8. --Suspend VM's---
echo [!resume!] 9. --Resume VM's---
echo [!destroy!] 0. ---Destroy all VMs---
echo c. Continue with selected options
echo q. Quit

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

if "!choice!"=="6" (
    set grafanaprometheus=1
    goto menu
)

if "!choice!"=="7" (
    set all=1
    goto menu
)

if "!choice!"=="8" (
    set suspend=1
    goto menu
)

if "!choice!"=="9" (
    set resume=1
    goto menu
)

if "!choice!"=="0" (
    set destroy=1
    goto menu
)

if "!choice!"=="c" (

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
	echo ArgoCD has been installed!
	)

	if "!grafanaprometheus!"=="1" (

	echo Copying Vagrantfile1 to Vagrantfile...
    copy /y Vagrantfile2 Vagrantfile
    echo Running 'vagrant provision node1 --provision-with GrafanaPrometheus_git-clone,GrafanaPrometheus_perms,GrafanaPrometheus_ownership,GrafanaPrometheus_install --color'...
    vagrant provision node1 --provision-with GrafanaPrometheus-clone,GrafanaPrometheus_perms,GrafanaPrometheus_ownership,GrafanaPrometheus_install --color
	echo GrafanaPrometheus has been installed!
	)

	if "!all!"=="1" (

    echo Copying Vagrantfile1 to Vagrantfile...
    copy /y Vagrantfile1 Vagrantfile
	vagrant up --color
    echo Copying Vagrantfile1 to Vagrantfile...
    copy /y Vagrantfile2 Vagrantfile
    echo Installing all options
    vagrant provision node1 --provision-with K8-metrics-server_perms,K8-metrics-server_ownership,K8-metrics-server_install,K8-dashboard_git-clone,K8-dashboard_perms,K8-dashboard_ownership,K8-dashboard_install,Jenkins-with-TF_git-clone,Jenkins-with-TF_perms,Jenkins-with-TF_ownership,Jenkins-with-TF_install,ArgoCD_git-clone,ArgoCD_perms,ArgoCD_ownership,ArgoCD_install,GrafanaPrometheus-clone,GrafanaPrometheus_perms,GrafanaPrometheus_ownership,GrafanaPrometheus_install --color
    copy /y Vagrantfile1 Vagrantfile
    echo K8 cluster with K8-metrics-server, K8-dashboard, Jenkins_with_TF, ArgoCD and Grafana/Prometheus has been installed!
	)

	if "!suspend!"=="1" (

	echo Suspending VMs...
    copy /y Vagrantfile1 Vagrantfile
    echo Running 'vagrant suspend'...
    vagrant suspend
	echo VMs have been suspended
	)

	if "!resume!"=="1" (

	echo Resuming VMs...
    copy /y Vagrantfile1 Vagrantfile
    echo Running 'vagrant resume'...
    vagrant resume
	echo VMs have been resumed
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
    set resume=0
    set suspend=0
    set destroy=0
	echo K8 3-node cluster has been destroyed!
	)

	if "!choice!"=="q" (
    set basicK8=0
    set k8Metrics=0
    set k8Dashboard=0
    set jenkins=0
    set argoCD=0
    set all=0
    set resume=0
    set suspend=0
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
    set resume=0
    set suspend=0
    set destroy=0

)

if "!choice!"=="q" (
    set basicK8=0
    set k8Metrics=0
    set k8Dashboard=0
    set jenkins=0
    set argoCD=0
    set all=0
    set suspend=0
    set destroy=0
	exit
)
endlocal