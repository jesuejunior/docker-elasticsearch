# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
   # https://docs.vagrantup.com.

  config.vm.hostname = "app"
  config.vm.box = "centos-muxi"
  config.vm.box_url = "http://192.168.1.24/files/centos7.box"

  # accessing "localhost:8000" will access port 8000 on the guest machine.
  config.vm.network "forwarded_port", guest: 9200, host: 9200
  config.vm.network "forwarded_port", guest: 9300, host: 9300

  config.vm.synced_folder ".", "/app",  type: "virtualbox"

  config.vm.provider "virtualbox" do |vb|
     vb.memory = "512"
   end

  config.vm.provision "shell", inline: <<-SHELL
  SHELL
end
