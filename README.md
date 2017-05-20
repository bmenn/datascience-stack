# datascience-stack

This repo provides Ansible scripts to deploy an opinionated data science
stack with various data science tools and support services, so teams can
quickly begin work instead of building infrastructure.

## Local testing
    1. Install vagrant
    2. Run `./vagrant-setup.sh` to setup Vagrant plugins.
    3. Run `vagrant up`
    4. Run `ansible-playbook -i local site.yml`
