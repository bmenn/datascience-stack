# vim: set tabstop=2 shiftwidth=2 expandtab softtabstop=0:
N = 4
VAGRANT_VM_PROVIDER = "virtualbox"

Vagrant.configure(2) do |config|
  (1..N).each do |i|
    config.vm.define "local-n#{i}" do |node|
      node.vm.provider "virtualbox" do |vb|
        vb.memory = 4096
        vb.cpus = 2
      end

      node.vm.box = "ubuntu/xenial64"
      node.vm.hostname = "local-n#{i}"
      node.vm.network "public_network"
      node.vm.network "forwarded_port", guest: 22, host: (2200 + i - 1), id: "ssh"
    end
  end
end
