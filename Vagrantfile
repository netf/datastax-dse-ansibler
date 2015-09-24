# -*- mode: ruby -*-
# vi: set ft=ruby :
#

Vagrant.configure(2) do |config|
  config.vm.provision "shell", inline: "yum install -y wget"
  config.vm.provision "ansible" do |ansible| 
    ansible.playbook = "playbook.yml"
  end

  # number of nodes in a cluster. 3 to 5 is reasonable for learning.
  N = 3
  (1..N).each do |cassandra_id|
    config.vm.define "cassandra#{cassandra_id}" do |cassandra|
      cassandra.vm.hostname = "cassandra#{cassandra_id}"
      cassandra.vm.box = "hansode/centos-6.7-x86_64"
      cassandra.vm.network "private_network", ip: "192.168.100.#{100+cassandra_id}"
    end
  end

  #config.vm.define "cassandra1" do |cassandra1|
  #  cassandra1.vm.box = "hansode/centos-6.7-x86_64"
  #end
  #config.vm.define "cassandra2" do |cassandra2|
  #  cassandra2.vm.box = "hansode/centos-6.7-x86_64"
  #end
  #config.vm.define "cassandra3" do |cassandra3|
  #  cassandra3.vm.box = "hansode/centos-6.7-x86_64"
  #end
end
