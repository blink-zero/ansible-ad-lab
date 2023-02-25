# Ansible AD (Active Directory) Lab
<img alt="GitHub release (latest by date)" src="https://img.shields.io/github/v/release/blink-zero/ansible-ad-lab?style=for-the-badge"> <img alt="GitHub Release Date" src="https://img.shields.io/github/release-date/blink-zero/ansible-ad-lab?style=for-the-badge"> <img alt="GitHub Release Date" src="https://img.shields.io/badge/Tested%20with%20Ansible%20version-2.9.27-orange?style=for-the-badge">

Ansible playbook to automate the creation and configuration of an Active Directory home and/or work lab environment using VMware. 

## Table Of Contents

1. [Description](https://github.com/blink-zero/ansible-ad-lab#description)
1. [Playbook Structure](https://github.com/blink-zero/ansible-ad-lab#playbook-structure)
1. [Getting Started](https://github.com/blink-zero/ansible-ad-lab#getting-started)
1. [Running The Playbook](https://github.com/blink-zero/ansible-ad-lab#running-the-playbook)
1. [Examples](https://github.com/blink-zero/ansible-ad-lab#examples)
1. [Help](https://github.com/blink-zero/ansible-ad-lab#help)
1. [Version History](https://github.com/blink-zero/ansible-ad-lab#version-history)
1. [Acknowledgements](https://github.com/blink-zero/ansible-ad-lab#acknowledgments)

## Description

The build consists of an Active Directory Domain Controller and both Windows and Linux machines. The code streamlines the provisioning and configuration process, enabling users to set up a home or work lab environment quickly and easily. The project is designed for those who want to learn about Active Directory, or for those who need to test and develop solutions for a multi-platform environments.

The code can be easily modified to suit specific lab environment by editing the [vars/*.yml](https://github.com/blink-zero/ansible-ad-lab/tree/main/vars) files after running [config.sh](https://github.com/blink-zero/ansible-ad-lab/blob/main/config.sh).

## Playbook Structure

```
ansible-ad-lab
├── scripts
│   └── powershell
|     ├── ad_scripts
|     └── general_scripts
├── tasks
│   ├── vmware_create_ad
|   | └── main.yml
|   ├── vmware_create_linux_clients
|   | └── main.yml
|   ├── vmware_create_linux_servers
|   | └── main.yml
|   ├── vmware_create_windows_clients
|   | └── main.yml
|   └── vmware_create_windows_servers
|     └── main.yml
├── templates
|   └── *.j2
├── vars
|   ├── ad_vars.yml.example
|   ├── common_vars.yml.example
|   └── vsphere_vars.yml.example
├── inventory_custom.ini.example
├── main.yml
├── requirements.txt
├── config.sh
└── README.md
```
- `scripts/`: directory containing scripts and other files required by the playbook.
- `tasks/`: directory containing tasks that will be run by the playbook.
- `templates/`: directory containing files for ubuntu realm join.
- `vars/`: directory for yml variable files.
- `inventory_custom.ini.example`: example inventory of machines to create.
- `main.yml`: main playbook in root folder.
- `requirements.txt`: dependancies for playbook to run.
- `readme.md`: instructions and links related to this playbook.
- `config.sh`: renames example vars files and inventory file.

## Getting Started

### Dependencies

* VMware vCenter (vSphere) Environment
    * Tested on: Version 7.0.3

* VMware templated virtual machines - Template Naming Convention Example `linux-ubuntu-22.04-lts-v23.01`
    * Tested and working with:
        * Windows
            * [Windows Server 2019 Datacenter](https://www.microsoft.com/en-us/evalcenter/download-windows-server-2019)
            * [Windows Server 2019 Core](https://www.microsoft.com/en-us/evalcenter/download-windows-server-2019)
            * [Windows Server 2022 Datacenter](https://www.microsoft.com/en-us/evalcenter/download-windows-server-2022)
            * [Windows Server 2022 Core](https://www.microsoft.com/en-us/evalcenter/download-windows-server-2022)
            * [Windows 10 Enterprise](https://www.microsoft.com/en-us/evalcenter/evaluate-windows-10-enterprise)
        * Linux
            * [CentOS 7.9](https://www.centos.org/download/)
            * [Ubuntu 18.04](https://releases.ubuntu.com/18.04/)
            * [Ubuntu 20.04](https://releases.ubuntu.com/20.04/)
            * [Ubuntu 22.04](https://releases.ubuntu.com/22.04/)

* Ansible - Tested on: Version 2.9.27
    * See [requirements.txt](https://github.com/blink-zero/ansible-ad-lab/blob/main/requirements.txt) for other dependancies
    * [sshpass](https://www.redhat.com/sysadmin/ssh-automation-sshpass) may also be required, `yum/apt install sshpass`
    * [community.vmware collection](https://docs.ansible.com/ansible/latest/collections/community/vmware/index.html), `ansible-galaxy collection install community.vmware`

## Running the Playbook

On your Ansible Control Node:

* Clone this repo
```sh
git clone https://github.com/blink-zero/ansible-ad-lab.git
```
* Change dir to cloned dir
```sh
cd ansible-ad-lab
```
* Install requirements
```sh
pip install -r requirements.txt
```
* Run config.sh to rename example var files and inventory file
```sh
chmod +x config.sh
./config.sh
```
* Modify vars/*.yml (See Examples)

* Modify inventory_*.ini (See Examples)

* Modify ad_import_users.csv

* Run playbook with inventory file
```sh
ansible-playbook main.yml -i inventory_custom.ini
```
* Enter in passwords when prompted


## Examples

### Executing (Example)

```sh
ansible-playbook main.yml -i inventory_custom.ini
```

### vars/ad_vars.yml Configuration (Example)

```yaml
---
ad_domain: "lab.example.local"
ad_new_domain_admin_password: 'R@in!$aG00dThing.'
ad_ntp_servers: "0.us.pool.ntp.org,1.us.pool.ntp.org,2.us.pool.ntp.org,3.us.pool.ntp.org"
ad_centos_ou_membership: OU=Computers,DC=lab,DC=example,DC=local
ad_ubu_ou_membership: CN=Computers,DC=lab,DC=example,DC=local
ad_recovery_password: 'R@in!$aG00dThing.'
ad_reverse_dns_zone: "172.16.0.0/24"
ad_upstream_dns_1: 8.8.8.8
ad_upstream_dns_2: 8.8.4.4
```
### vars/common_vars.yml Configuration (Example)

```yaml
---
common_dns2: "172.16.0.1"
common_domain_admin: '{{ad_domain}}\administrator'
common_domain_admin_simple_name: 'administrator'
common_gateway: "172.16.0.1"
common_lin_disk_size: 40
common_local_admin: '.\administrator'
common_lin_local_admin: 'administrator'
common_netmask: "255.255.255.0"
common_timezone: "255"
common_vm_hw_scsi: "paravirtual"
common_vm_net_name: "VM Network"
common_vm_net_type: "vmxnet3"
common_vm_state: "poweredon"
common_win_disk_size: 100
```
### vars/vsphere_vars.yml Configuration (Example)

```yaml
---
vsphere_esxi_host: "192.168.0.21"
vsphere_vcenter_datacenter: "Datacenter"
vsphere_vcenter_hostname: "vc.example.local"
vsphere_vcenter_username: "administrator@vsphere.local"
vsphere_vcenter_validate_certs: false
vsphere_vm_disk_datastore: "Datastore_name"
vsphere_vm_folder: "Lab"
vsphere_vm_type: "thin"
```
### inventory_custom.ini Configuration (Example) - Full List of Tested OS below

> Note:
> Comment out lines with ';' to disable building that machine.

```ini
[dc]
172.16.0.20 inventory_guest_hostname='2022DC01' inventory_guest_vcpu='2' inventory_guest_vram='4096' inventory_template_name='windows-server-2022-datacenter-dexp-v23.01' inventory_vm_guestid='windows9Server64Guest'
[win_server]
172.16.0.50 inventory_guest_hostname='2022SERVER01' inventory_guest_vcpu='2' inventory_guest_vram='4096' inventory_template_name='windows-server-2022-datacenter-dexp-v23.01' inventory_vm_guestid='windows9Server64Guest'
172.16.0.51 inventory_guest_hostname='2022SERVER02' inventory_guest_vcpu='2' inventory_guest_vram='4096' inventory_template_name='windows-server-2022-datacenter-core-v23.01' inventory_vm_guestid='windows9Server64Guest'
172.16.0.52 inventory_guest_hostname='2019SERVER01' inventory_guest_vcpu='2' inventory_guest_vram='4096' inventory_template_name='windows-server-2019-datacenter-dexp-v23.01' inventory_vm_guestid='windows9Server64Guest'
172.16.0.53 inventory_guest_hostname='2019SERVER02' inventory_guest_vcpu='2' inventory_guest_vram='4096' inventory_template_name='windows-server-2019-datacenter-core-v23.01' inventory_vm_guestid='windows9Server64Guest'
[win_client]
172.16.0.101 inventory_guest_hostname='W10CLIENT01' inventory_guest_vcpu='2' inventory_guest_vram='4096' inventory_template_name='windows-desktop-10-enterprise-v23.01' inventory_vm_guestid='windows9Server64Guest'
172.16.0.102 inventory_guest_hostname='W10CLIENT02' inventory_guest_vcpu='2' inventory_guest_vram='4096' inventory_template_name='windows-desktop-10-enterprise-v23.01' inventory_vm_guestid='windows9Server64Guest'
172.16.0.103 inventory_guest_hostname='W10CLIENT03' inventory_guest_vcpu='2' inventory_guest_vram='4096' inventory_template_name='windows-desktop-10-enterprise-v23.01' inventory_vm_guestid='windows9Server64Guest'
172.16.0.104 inventory_guest_hostname='W10CLIENT04' inventory_guest_vcpu='2' inventory_guest_vram='4096' inventory_template_name='windows-desktop-10-enterprise-v23.01' inventory_vm_guestid='windows9Server64Guest'
[lin_server]
172.16.0.61 inventory_guest_hostname='CO7SERVER01' inventory_guest_vcpu='1' inventory_guest_vram='2048' inventory_template_name='linux-centos-7-v23.01' inventory_vm_guestid='centos64Guest'
172.16.0.62 inventory_guest_hostname='UBUSERVER01' inventory_guest_vcpu='2' inventory_guest_vram='4096' inventory_template_name='linux-ubuntu-18.04-lts-v23.01' inventory_vm_guestid='ubuntu64Guest'
172.16.0.63 inventory_guest_hostname='UBUSERVER02' inventory_guest_vcpu='2' inventory_guest_vram='4096' inventory_template_name='linux-ubuntu-20.04-lts-v23.01' inventory_vm_guestid='ubuntu64Guest'
172.16.0.64 inventory_guest_hostname='UBUSERVER03' inventory_guest_vcpu='2' inventory_guest_vram='4096' inventory_template_name='linux-ubuntu-22.04-lts-v23.01' inventory_vm_guestid='ubuntu64Guest'
[lin_client]
172.16.0.201 inventory_guest_hostname='CO7CLIENT01' inventory_guest_vcpu='1' inventory_guest_vram='2048' inventory_template_name='linux-centos-7-v23.01' inventory_vm_guestid='centos64Guest'
172.16.0.202 inventory_guest_hostname='UBUCLIENT01' inventory_guest_vcpu='2' inventory_guest_vram='4096' inventory_template_name='linux-ubuntu-18.04-lts-v23.01' inventory_vm_guestid='ubuntu64Guest'
172.16.0.203 inventory_guest_hostname='UBUCLIENT02' inventory_guest_vcpu='2' inventory_guest_vram='4096' inventory_template_name='linux-ubuntu-20.04-lts-v23.01' inventory_vm_guestid='ubuntu64Guest'
172.16.0.204 inventory_guest_hostname='UBUCLIENT03' inventory_guest_vcpu='2' inventory_guest_vram='4096' inventory_template_name='linux-ubuntu-22.04-lts-v23.01' inventory_vm_guestid='ubuntu64Guest'
```

## Help

> How do I create the 'Golden Images' VMware Template?
* See: [packer-examples-for-vsphere](https://github.com/vmware-samples/packer-examples-for-vsphere)

> How do I install Ansible?
* Please refer to the Ansible documentation for install guidance: [Ansible Install](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

> Why is Ansible saying X module is missing?

* Run `pip install -r requirements.txt` before running playbook


## Version History
* v1.2.0 (Latest)
    * Added GUI to Linux Client machines
        * Support for Ubuntu 18.04, 20.04, 22.04 and CentOS 7
    * Added Linux Realm join
        * Support for Ubuntu 18.04, 20.04, 22.04 and CentOS 7
    * Powershell script folders and files deleted after use
    * Various code clean up
* v1.1.0
    * Cleaned up variables
    * Rebuilt vars files (common, vsphere, ad)
    * Added Powershell scripts for Client/Server Applications
    * Split inventory into clients/servers
    * config.sh added for renaming example var files
* v1.0.0
    * Initial Release

## Acknowledgments

Inspiration, code snippets, etc.
* [blink-zero/ansible-deploy-vm](https://github.com/blink-zero/ansible-deploy-vm)
* [madlabber/examples](https://github.com/madlabber/examples)
* [vmware-samples/packer-examples-for-vsphere](https://github.com/vmware-samples/packer-examples-for-vsphere)
* [tvories/ansible-realmd](https://github.com/tvories/ansible-realmd)
