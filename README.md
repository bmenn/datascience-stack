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

## Deploying
This repository assumes that Ubuntu 16.04 is already installed on each
server in the cluster.

  1. Run `ansible-playbook -i your_inventory_file_here site.yml`

## Credentials, Secrets, Tokens, etc
### Jupyter Notebook Token
The Jupyter notebook token can be retrieved running `docker service ps
jupyter-notebook` on the Docker Swarm manager (if using the default local
deployment, it is `local-n1`), note the nodes that the service is running on and
running `docker logs <container_id>`, where `<container_id>` is the ID of
the Jupyter notebook container.

*Local Deployment Example*:
On `local`

```
ubuntu@local-n1:~$ sudo docker service ps jupyter-notebook
ID            NAME                IMAGE                              NODE      DESIRED STATE  CURRENT STATE           ERROR  PORTS
hc27dmdb4e93  jupyter-notebook.1  bmenn/datascience-notebook:latest  local-n4  Running        Running 13 minutes ago
```

On `local-n4`

```
ubuntu@local-n4:~$ sudo docker ps
CONTAINER ID        IMAGE                                                                                              COMMAND                  CREATED             STATUS              PORTS NAMES
1dfc74847a00        bmenn/datascience-notebook@sha256:731cd631d11979d780600da28d8da22936088f959d91cbd7a958b31e88a41c5d "tini -- start-not..."   40 seconds ago      Up 39 seconds       8888/tcp jupyter-notebook.1.hc27dmdb4e93xkz2wxw30ptph
ubuntu@local-n4:~$ sudo docker logs 1dfc74847a00
[I 05:55:44.549 NotebookApp] Writing notebook server cookie secret to
/home/jovyan/.local/share/jupyter/runtime/notebook_cookie_secret
[W 05:55:45.075 NotebookApp] WARNING: The notebook server is listening on
all IP addresses and not using encryption. This is not recommended.
[I 05:55:45.146 NotebookApp] Loading IPython parallel extension
[I 05:55:45.168 NotebookApp] JupyterLab alpha preview extension loaded from
/opt/conda/lib/python3.5/site-packages/jupyterlab
[I 05:55:45.194 NotebookApp] Serving notebooks from local directory: /nfs
[I 05:55:45.194 NotebookApp] 0 active kernels
[I 05:55:45.194 NotebookApp] The Jupyter Notebook is running at: http://[all
ip addresses on your
system]:8888/?token=16feb4689a2ebeef295a0e5f95c4709127e7568130d63930
[I 05:55:45.194 NotebookApp] Use Control-C to stop this server and shut down
all kernels (twice to skip confirmation).
[C 05:55:45.194 NotebookApp]

    Copy/paste this URL into your browser when you connect for the first
    time,
        to login with a token:
                http://localhost:8888/?token=16feb4689a2ebeef295a0e5f95c4709127e7568130d63930

```

### Ceph RADOS Gateway (i.e. S3 API support)
The S3 access key and secret key for the RADOS gateway can be retrieve by
running the following on a gateway node (where `<userid>` is replaced with
the actual user ID):

```
sudo radosgw-admin user info --uid=<userid>
```

## Tips and Tricks
### Waiting for public Docker repo download takes too long
The Docker daemons deployed can be configured using `registry_mirror` and
`insecure_registry` Ansible variables to use a closer Docker registry.
