#!/usr/bin/env bash

# 2020-10-07

# install required package
sudo yum install -y yum-utils \
  device-mapper-persistent-data 

sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum makecache fast

# install and start docker
sudo yum install -y docker-ce docker-ce-cli containerd.io
systemctl enable docker
systemctl start docker

# add the current user to docker group
# https://docs.docker.com/engine/install/linux-postinstall/
sudo groupadd docker
sudo usermod -aG docker vagrant

# install docker-compose 
# https://docs.docker.com/compose/install/
curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
# Command-line completion 
https://docs.docker.com/compose/completion/ 
yum install bash-completion bash-completion-extras
curl -L https://raw.githubusercontent.com/docker/compose/1.27.4/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose


# other tools
sudo yum install -y vim
sudo yum install -y net-tools

# timezone
sudo timedatectl set-timezone CET
sudo yum install -y ntpdate

# expose docker to tcp://127.0.0.1:2375
# https://docs.docker.com/engine/install/linux-postinstall/
tee /usr/lib/systemd/system/docker.service <<-'EOF'
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd -H unix:// -H tcp://127.0.0.1:2375
EOF
sudo systemctl daemon-reload

