# RafK8clstr

## Introduction

RafK8clstr is a project that aims to provide a simplified way to set up a 3-node Kubernetes cluster with various add-ons and features like Metrics Server and NFS shared storage. The project uses Vagrant and VirtualBox for local VM provisioning and includes a variety of scripts to aid in the setup.
It contains a "wrapper" (setup.bat file) which handles vagrant and allows deploying various devops components from my repos.

## Features

- 3-node Kubernetes cluster setup based on containerd container runtime
- K8 Metrics Server integration
- NFS Shared Storage configured
- Automated Helm setup

## Technology used
<a href="https://argo-cd.readthedocs.io/" title="argo-cd"><img src="icons/argocd.png" /></a>
<a href="https://www.docker.com/" title="Docker"><img src="icons/docker.png" /></a>
<a href="https://www.github.com/" title="github"><img src="icons/github.png" /></a>
<a href="https://helm.sh/" title="helm"><img src="icons/helm.png" /></a>
<a href="https://www.jenkins.io/" title="helm"><img src="icons/jenkins.png" /></a>
<a href="https://kubernetes.io/" title="kubernetes"><img src="icons/k8.png" /></a>
<a href="https://www.terraform.io/" title="terraform"><img src="icons/terraform.png" /></a>
<a href="https://www.vagrantup.com/" title="vagrantup"><img src="icons/vagrant.png" /></a>
<a href="https://www.virtualbox.org/" title="vagrantup"><img src="icons/virtualbox.png" /></a>

Please note that currently K8 version used is 1.26.

## Prerequisites

- HashiCorp Vagrant (tested on 2.3.2 - 2.3.4)
- Oracle VirtualBox (tested on 7.0.2 r154219)
- PC with at least 32GB RAM

## Installation and Setup

1. Install Vagrant
2. Install VirtualBox
3. Open command line and clone the repository using `git clone https://github.com/kozraf/RafK8clstr.git`
4. Navigate to the project directory: `cd RafK8clstr`
5. Run `vagrant init` 
6. Run the setup script:
    - For Windows: `setup.bat`
    - For Linux: `bash setup.sh` 
7. If K8 cluster is not installed - press '1' to select K8-basic and then press 7 to proceed

Feel free to select other options as well  and their will be installed once K8 cluster is deployed.
I highly recommend to install at least K8 metrics and K8 dashboard. Other tools are optional.

8. If for some reason you would like to delete K8 cluster - select option '0' and '7' to proceed.
9. Logon to node1 using 'vagrant ssh node1' and from there you can manage your cluster using 'kubectl' commands


## Usage (once K8 cluster is deployed)

- To start the cluster: `vagrant up`
- To stop the cluster: `vagrant halt` or `vagrant suspend`
- To destroy the cluster: `vagrant destroy` or use setup.bat

## Notes
- when installing additional tools with setup.bat - corresponding repos are pulled from my https://github.com/kozraf account
- Helm is installed when basicv K8 cluster is deployed as it is used for other tools

## Contributing

Contributions are welcome! Please read the contributing guidelines to get started.

## Troubleshooting

- make sure that VirtualBox can use 192.168.89.141-143/24 IP address. If you need to change it - adjust corresponding lines in Vagrantfile1

## License

The scripts, configurations, and documentation in this project are licensed under the MIT License. This license applies only to the scripts, configurations, and documentation contained in this repository (RafK8clstr) and not to the software they interact with. For the full license text and disclaimer, please see the [LICENSE](LICENSE) file in the project's repository.

