# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure(2) do |config|
  (1..3).each do |i|
    config.vm.define "bdi-#{i}" do |node|
      node.vm.provider "virtualbox" do |vb|
        vb.memory = "2048"
      end

      node.vm.box = "ubuntu/trusty64"
      node.vm.provision "docker" do |d|
        d.images = ["swarm", "gliderlabs/consul"]
        d.run "gliderlabs/consul",
          daemonize: true,
          cmd: "/bin/consul -server -bootstrap-expect 3"
      end
    end
  end
end
