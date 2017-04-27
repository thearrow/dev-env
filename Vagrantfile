# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-16.04"
  config.vm.box_check_update = true

  config.vm.hostname = "vagrant"
  config.vm.network "private_network", ip: "192.168.50.50"

  config.vm.provider "virtualbox" do |v|
    v.name = "vagrant"
    v.cpus = 2
    v.memory = 8000
  end

  config.vm.provision "shell", path: "vagrant.sh"
end
