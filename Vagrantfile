# vim: set tabstop=2 shiftwidth=2 expandtab softtabstop=0:
N = 3
VAGRANT_VM_PROVIDER = "virtualbox"
ANSIBLE_RAW_SSH_ARGS = []

Vagrant.configure(2) do |config|
  (1..N-1).each do |machine_id|
    ANSIBLE_RAW_SSH_ARGS << "-o IdentityFile=.vagrant/machines/bdi-#{machine_id}/#{VAGRANT_VM_PROVIDER}/private_key"
  end

  (1..N).each do |i|
    config.vm.define "bdi-#{i}" do |node|
      node.vm.provider "virtualbox" do |vb|
        vb.memory = 4096
        vb.cpus = 2
      end

      node.vm.box = "ubuntu/trusty64"
      node.vm.hostname = "bdi-#{i}"
      node.vm.network "public_network"
      node.vm.network "forwarded_port", guest: 22, host: (2200 + i - 1), id: "ssh"


      # node.vm.provision "docker" do |d|
      #   d.images = ["gliderlabs/consul"]
      #   d.build_image "/vagrant/docker/hadoop", args: "-t hadoop"
      #   d.run "consul",
      #     image: "gliderlabs/consul",
      #     daemonize: true,
      #     restart: "no",
      #     args: "-p 8400:8400 -p 8500:8500 -p 8600:53/udp -p 8301:8301 -p 8301:8301/udp -p 8302:8302 -p 8302:8302/udp -p 8300:8300",
      #     cmd: "agent -server -bootstrap-expect 3 -data-dir=/tmp/consul -advertise=$(dig +short bdi-#{i}) -client=0.0.0.0"
      #   d.run "hadoop",
      #     image: "hadoop",
      #     daemonize: true,
      #     restart: "no"
      # end

      if i == N
        node.vm.provision "ansible" do |ansible|
          ansible.inventory_path = "local"
          ansible.playbook = "site.yml"
          ansible.limit = "all"
          ansible.raw_ssh_args = ANSIBLE_RAW_SSH_ARGS
          ansible.verbose = "vvvv"
        end
      end
    end
  end
  # config.trigger.after :provision do
  #   run "bin/bootstrap-consul.sh"
  # end
end
