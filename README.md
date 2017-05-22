# datascience-stack

This repo provides Ansible scripts to deploy an opinionated data science
stack with various data science tools and support services, so teams can
quickly begin work instead of building infrastructure.

## Local testing
Requirements for local testing:
  * >=16GB RAM
  * Enough space for Vagrant box image *PLUS* 4x 15GB Virtualbox VDI's. 80GB
    should be enough

Instructions:
    1. Install vagrant
    2. Run `./vagrant-setup.sh` to setup Vagrant plugins.
    3. Run `vagrant up`
    4. Run `./install_ansible_roles.sh`
    5. Run `ANSIBLE_ROLES_PATH=${ANSIBLE_ROLES_PATH}:${HOME}/.ansible/roles ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i local site.yml`

The S3 access key and secret key for the RADOS gateway can be retrieve by
running the following on a gateway node (where `<userid>` is replaced with
the actual user ID):

```
sudo radosgw-admin user info --uid=<userid>
```

## Deploying
This repository assumes that Ubuntu 16.04 is already installed on each
server in the cluster.

  1. Run `ansible-playbook -i your_inventory_file_here site.yml`
