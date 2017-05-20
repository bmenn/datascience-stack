# datascience-stack

This repo provides Ansible scripts to deploy an opinionated data science
stack with various data science tools and support services, so teams can
quickly begin work instead of building infrastructure.

## Local testing
    . Install vagrant
    . Run `./vagrant-setup.sh` to setup Vagrant plugins.
    . Run `vagrant up`
    . Run `ansible-playbook -i local site.yml`
