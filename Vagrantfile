# options are documented and commented below. For a complete reference,
# please see the online documentation at vagrantup.com.
# Every Vagrant development environment requires a box. You can search for
# boxes at https://vagrantcloud.com/search.

Vagrant.configure("2") do |config|

  config.env.enable # enable the plugin
  config.vm.box = "centos/7"
  config.vm.hostname = "dockerhost"
  config.disksize.size = "15GB" # rootvg size /dev/sda1/

  config.ssh.extra_args = ["-t", "cd /home/vagrant; bash --login"] # https://stackoverflow.com/questions/17864047/automatically-chdir-to-vagrant-directory-upon-vagrant-ssh
  config.vagrant.plugins = "vagrant-env"

  # VM network 
  config.vm.network :private_network, type: "dhcp", ip: "192.168.3.172"
  config.vm.network :forwarded_port, host: 80, guest: 80

  # VM cpu, mem, disks + second disk for lvm
  config.vm.provider "virtualbox" do |vb|

    disk = "./vm/sdb.vmdk"
    unless File.exist?(disk)
        vb.customize ['createhd', '--filename', disk, '--variant', 'Fixed', '--size', 20 * 1024]
    end
    vb.memory = 6092
    vb.cpus = 2
    vb.customize ['storageattach', :id,  '--storagectl', 'IDE', '--port', 1, '--device', 1, '--type', 'hdd', '--medium', disk]
  end

  #config.vm.provision :shell, path: "provision.sh", keep_color: "true"

  # VM provisioning
  config.vm.provision :shell, path: "./provision_lvm.sh"
  #config.vm.provision :shell, path: "provision_docker.sh"
  config.vm.synced_folder "../share", "/home/vagrant/share", type: "virtualbox"

end