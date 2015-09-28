# -*- mode: ruby -*-
# vi: set ft=ruby :
#

Vagrant.configure(2) do |config|
  # number of cassandra nodes in a cluster. 3 to 5 is reasonable for learning.
  CLUSTER_SIZE = 3
  VAGRANT_IMAGE = "ubuntu/trusty64"

  config.vm.define "openldap" do |openldap|
    ip_address = "192.168.100.99"
    openldap.vm.hostname = "openldap"
    openldap.vm.box = VAGRANT_IMAGE
    openldap.vm.network "private_network", ip: "#{ip_address}"
    openldap.vm.provider "virtualbox" do |v|
      v.cpus = 2
      v.memory = 1024
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--ioapic", "on"]
    end
    openldap.vm.provision :ansible do |ansible|
      ansible.playbook = "playbook.yml"
    end
  end

  (1..CLUSTER_SIZE).each do |cassandra_id|
    config.vm.define "cassandra#{cassandra_id}" do |cassandra|
      ip_address = "192.168.100.#{100 + cassandra_id}"
      group ||= []
      group << "cassandra#{cassandra_id}"
      if cassandra_id <= 3
        seeds ||= ""
        seeds << "#{ip_address},"
      end
      cassandra.vm.hostname = "cassandra#{cassandra_id}"
      cassandra.vm.box = VAGRANT_IMAGE
      cassandra.vm.network "private_network", ip: "#{ip_address}"
      cassandra.vm.provider "virtualbox" do |v|
        v.cpus = 2
        v.memory = 2048
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        v.customize ["modifyvm", :id, "--ioapic", "on"]
      end

      if cassandra_id == CLUSTER_SIZE
        cassandra.vm.provision :ansible do |ansible|
        ansible.limit = "all"
          ansible.extra_vars = {
            seeds: seeds.chomp(",")
          }
          ansible.groups = {
            "cassandra" => group
          }
          ansible.playbook = "playbook.yml"
        end
      end
    end
  end
end
