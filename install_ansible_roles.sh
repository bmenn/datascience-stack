#!/bin/sh
export ANSIBLE_ROLES_PATH=${HOME}/.ansible/roles
mkdir -p "${ANSIBLE_ROLES_PATH}"

ansible-galaxy install \
        ceph.ceph-docker-common \
        ceph.ceph-mon \
        ceph.ceph-osd \
        ceph.ceph-mds \
        ceph.ceph-rgw \
        ceph.ceph-restapi
