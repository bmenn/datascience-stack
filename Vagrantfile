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
        d.images = ["gliderlabs/consul", "sequenceiq/hadoop-docker:2.4.1"]
        d.run "consul",
          image: "gliderlabs/consul",
          daemonize: true,
          restart: "no",
          args: "-p 8400:8400 -p 8500:8500 -p 8600:53/udp -p 8301:8301 -p 8301:8301/udp -p 8302:8302 -p 8302:8302/udp -p 8300:8300",
          cmd: "agent -server -bootstrap-expect 3 -data-dir=/tmp/consul -advertise=$(dig +short bdi-#{i}) -client=0.0.0.0"
        d.run "hadoop",
          image: "sequenceiq/hadoop-docker:2.4.1",
          daemonize: true,
          restart: "always",
          args: "-p 50010:50010 -p 50020:50020 -p 50070:50070 -p 50075:50075 -p 50090:50090 -p 19888:19888 -p 8030:8030 -p 8031:8031 -p 8032:8032 -p 8033:8033 -p 8040:8040 -p 8042:8042 -p 8088:8088 -p 49707:49707 -p 2122:2122"
      end
    end
  end
end
