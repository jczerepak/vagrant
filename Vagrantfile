# options are documented and commented below. For a complete reference,
# please see the online documentation at vagrantup.com.
# Every Vagrant development environment requires a box. You can search for
# boxes at https://vagrantcloud.com/search.

Vagrant.configure("2") do |config|

  #config.vm.box = "generic/centos7"
  config.vm.box = "elastic/centos-7-x86_64"
  config.vm.hostname = "dockerhost"
  # install required plugins
  #if Vagrant.has_plugin?("vagrant-vbguest")
  #  config.vbguest.no_install = true
  #end
  config.vagrant.plugins = ["vagrant-vbguest", "vagrant-disksize", "vagrant-env", "vagrant-docker-compose", "vagrant-scp"]
  config.ssh.extra_args = ["-t", "cd /home/vagrant; bash --login"] # https://stackoverflow.com/questions/17864047/automatically-chdir-to-vagrant-directory-upon-vagrant-ssh
  
  # VM network 
  config.vm.network :private_network, type: "dhcp", ip: "192.168.3.172"
  config.vm.network :forwarded_port, host: 443, guest: 443
  config.vm.network :forwarded_port, host: 1443, guest: 1443
  for i in 8080..8089
    config.vm.network :forwarded_port,  host: i, guest: i
  end

  config.vm.provision "shell", inline: "yum install -y kernel-devel"
  
  # VM cpu, mem, disks + second disk for lvm
  config.vm.provider "virtualbox" do |vb|

    disk1 = "./vm/sdb.vmdk"
    disk2 = "./vm/sdc.vmdk"
    unless File.exist?(disk1)
        vb.customize ['createhd', '--filename', disk1, '--variant', 'Fixed', '--size', 20 * 1024]
    end
    unless File.exist?(disk2)
      vb.customize ['createhd', '--filename', disk2, '--variant', 'Fixed', '--size', 5 * 1024]
    end
    vb.memory = 10120
    vb.cpus = 2
    vb.customize ['storageattach', :id,  '--storagectl', 'IDE Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', disk1]
    vb.customize ['storageattach', :id,  '--storagectl', 'IDE Controller', '--port', 1, '--device', 1, '--type', 'hdd', '--medium', disk2]
  
  end
  config.vm.synced_folder "../share", "/home/vagrant/share", type: "virtualbox"

  # VM provisioning
  config.vm.provision :shell, path: "./provision_docker.sh"
  config.vm.provision :shell, path: "./provision_lvm.sh"
  config.vm.provision :shell, path: "./provision_portainer.sh"

end