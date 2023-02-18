# ansible-ad-lab

Ansible playbook to automate the creation and configuration of an Active Directory home and/or work lab environment using VMware. 

## Description

The build consists of an Active Directory domain controller and both Windows and Linux machines. The code streamlines the provisioning and configuration process, enabling users to set up a home or work lab environment quickly and easily. The project is designed for those who want to learn about Active Directory, or for those who need to test and develop solutions for a multi-platform environment. 

The code can be easily modified to suit specific lab environment by modifying the vars/main.yml.

## Playbook Structure

```
ansible-ad-lab
├── scripts
│   └── powershell
|     ├── ad_scripts
|     └── general_scripts
├── tasks
│   ├── vmware_create_ad
|   ├── vmware_create_windows
|   └── vmware_create_linux
├── vars
|   └── main.yml
├── inventory_small.ini
├── inventory_medium.ini
├── inventory_large.ini
├── inventory_custom.ini
├── main.yml
├── requirements.txt
└── README.md
```
- `scripts/`: directory containing scripts and other files required by the playbook.
- `tasks/`: directory containing tasks that will be run by the playbook.
- `vars/`: directory to save variable files.
- `inventory_x.ini`: inventory of machines to create.
- `main.yml`: main playbook.
- `requirements.txt`: dependancies for playbook to run.
- `readme.md`: instructions and links related to this playbook.

## Getting Started

### Dependencies

* VMware vCenter (vSphere) Environment
    * Tested on:
        * 7.0.1U
* VMware templated virtual machines
    * Tested on:
        * Windows Server 2019
        * Windows 10
        * CentOS 7.9
        * Ubuntu 20.04
* Ansible
    * with community.vmware collection

### Configuring and Running the Playbook

On your Ansible Control Node:

* Clone this repo
```bash
git clone https://github.com/blink-zero/ansible-ad-lab.git
```
* Change dir to cloned dir
* Install requirements
```bash
pip install -r requirements.txt
```
* Modify vars/main.yml (See Examples)

* Modify inventory_custom.ini (See Examples)

* Modify ad_import_users.csv

* Run playbook with inventory file
```bash
ansible-playbook main.yml -i inventory_custom.ini
```
* Enter in passwords when prompted


## Examples

### Executing

```sh
# There are multiple inventory files included. Feel free to modify to your needs.

# Example 1
ansible-playbook main.yml -i inventory_custom.ini

# Example 2
ansible-playbook main.yml -i inventory_small.ini
```

### vars/main.yml Configuration (Example)

```yaml
---
vcenter_hostname: "vc.example.com"
vcenter_username: "administrator@vsphere.local"
vcenter_datacenter: "SYD-DC"
domain: "domain.local"
local_admin: '.\administrator'
dc_password: 'P@ssw0rd'
recovery_password: 'P@ssw0rd'
reverse_dns_zone: "172.16.1.0/24"
upstream_dns_1: 8.8.8.8
upstream_dns_2: 8.8.4.4
ntp_servers: "0.us.pool.ntp.org,1.us.pool.ntp.org,2.us.pool.ntp.org,3.us.pool.ntp.org"
vcenter_validate_certs: false
timezone: "255"
esxi_host: "192.168.1.20"
vm_folder: "LAB"
vm_disk_datastore: "datastore_2TB"
disk_size: 100
vm_hw_scsi: "paravirtual"
vm_state: "poweredon"
vm_net_name: "Example Network [VLAN 20]"
vm_net_type: "vmxnet3"
netmask: "255.255.255.0"
gateway: "172.16.1.1"
dns1: "172.16.1.12"
dns2: "172.16.1.1"
```

### inventory_custom.ini Configuration (Example)

```ini
[dc]
172.16.1.20 guest_hostname='2019DC01' guest_vcpu='2' guest_vram='4096' template_name='WIN2019-TMP' vm_guestid='windows9Server64Guest'

[win]
172.16.1.51 guest_hostname='2019SERVER01' guest_vcpu='2' guest_vram='4096' template_name='WIN2019-TMP' vm_guestid='windows9Server64Guest'
172.16.1.52 guest_hostname='2019SERVER02' guest_vcpu='2' guest_vram='4096' template_name='WIN2019-TMP' vm_guestid='windows9Server64Guest'

[lin]
172.16.1.53 guest_hostname='COS7SERVER01' guest_vcpu='1' guest_vram='2048' template_name='CENTOS7-TMP' vm_guestid='centos64Guest'
```

## Help

How do I create the 'Golden Images' VMware Template?
```
See: https://github.com/vmware-samples/packer-examples-for-vsphere
```
How do I install Ansible?
```
Please refer to the Ansible documentation for install guidance: https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html
```
Why is Ansible saying X module is missing
```
Run 'pip install -r requirements.txt' before running playbook
```

## Version History

* v1.0.0
    * Initial Release

## Acknowledgments

Inspiration, code snippets, etc.
* [madlabber/examples](https://github.com/madlabber/examples)
