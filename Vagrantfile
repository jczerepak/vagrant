# options are documented and commented below. For a complete reference,
# please see the online documentation at vagrantup.com.
# Every Vagrant development environment requires a box. You can search for
# boxes at https://vagrantcloud.com/search.

Vagrant.configure("2") do |config|
  config.env.enable # enable the plugin
  config.vm.box = "centos/7"
  config.vm.hostname = "dockerhost"

  config.ssh.extra_args = ["-t", "cd /home/vagrant; bash --login"] #https://stackoverflow.com/questions/17864047/automatically-chdir-to-vagrant-directory-upon-vagrant-ssh
  config.vagrant.plugins = "vagrant-env"
  
  config.vm.network :private_network, type: "dhcp", ip: "192.168.3.172"

  config.vm.network :forwarded_port, host: 80, guest: 80
    
  config.vm.provider "virtualbox" do |vb|
    vb.memory = 6092 
    vb.cpus = 2
  end 
  
  config.vm.provision :shell, path: "./bootstrap.sh"
  config.vm.synced_folder "./../share", "/home/vagrant/share", type: "virtualbox"

end