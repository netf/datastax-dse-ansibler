# -*- mode: ruby -*-
# vi: set ft=ruby :
#

Vagrant.configure(2) do |config|
  config.vm.provision "shell", inline: "yum install -y wget"
  config.vm.provision "ansible" do |ansible| 
    ansible.playbook = "cassandra.yml"
  end
  config.vm.define "cassandra1" do |cassandra1|
    cassandra1.vm.box = "hansode/centos-6.7-x86_64"
  end
  config.vm.define "cassandra2" do |cassandra2|
    cassandra2.vm.box = "hansode/centos-6.7-x86_64"
  end
end
