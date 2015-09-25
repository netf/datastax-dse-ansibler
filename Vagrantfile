# -*- mode: ruby -*-
# vi: set ft=ruby :
#

Vagrant.configure(2) do |config|
  # number of cassandra nodes in a cluster. 3 to 5 is reasonable for learning.
  CLUSTER_SIZE = 3

  config.vm.define "openldap" do |openldap|
    ip_address = "192.168.100.99"
    openldap.vm.hostname = "openldap"
    openldap.vm.box = "hansode/centos-6.7-x86_64"
    openldap.vm.network "private_network", ip: "#{ip_address}"
    openldap.vm.provider "virtualbox" do |v|
      v.memory = 1024
    end
    openldap.vm.provision :ansible do |ansible|
      ansible.playbook = "playbook.yml"
    end
  end

  (1..CLUSTER_SIZE).each do |cassandra_id|
    config.vm.define "cassandra#{cassandra_id}" do |cassandra|
      ip_address = "192.168.100.#{100 + cassandra_id}"
      if cassandra_id <= 3
        seeds ||= ""
        seeds << "#{ip_address},"
      end
      cassandra.vm.hostname = "cassandra#{cassandra_id}"
      cassandra.vm.box = "hansode/centos-6.7-x86_64"
      cassandra.vm.network "private_network", ip: "#{ip_address}"
      cassandra.vm.provider "virtualbox" do |v|
          v.memory = 2048
      end

      if cassandra_id == CLUSTER_SIZE
        cassandra.vm.provision "shell", inline: "yum install -y wget"
        cassandra.vm.provision :ansible do |ansible|
          ansible.limit = "all"
          ansible.extra_vars = {
            seeds: seeds.chomp(",")
          }
          ansible.playbook = "playbook.yml"
        end
      end
    end
  end
end
