# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure(2) do |config|
  (1..3).each do |i|
    config.vm.define "bdi-#{i}" do |node|
      node.vm.provider "virtualbox" do |vb|
        vb.memory = 2048
        vb.cpus = 2
      end

      node.vm.box = "ubuntu/trusty64"
      node.vm.hostname = "bdi-#{i}"
      node.vm.network "public_network"

      node.vm.provision "docker" do |d|
        d.images = ["gliderlabs/consul"]
        d.run "consul",
          image: "gliderlabs/consul",
          daemonize: true,
          restart: "no",
          args: "-p 8400:8400 -p 8500:8500 -p 8600:53/udp -p 8301:8301 -p 8301:8301/udp -p 8302:8302 -p 8302:8302/udp -p 8300:8300",
          cmd: "agent -server -bootstrap-expect 3 -data-dir=/tmp/consul -advertise=$(dig +short bdi-#{i}) -client=0.0.0.0"
      end
    end
  end

  config.trigger.after :provision do
    run "bin/bootstrap-consul.sh"
  end
end
