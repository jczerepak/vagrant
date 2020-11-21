# Portainer is configured based on:
# https://codeopolis.com/posts/how-to-install-portainer-on-docker/

#!/bin/sh
sudo mkdir -p /docker/security
sudo mkdir -p /docker/docker_data

sudo chown -R vagrant. /docker/security
sudo chown -R vagrant. /docker/docker_data

# generate certificate for portainer
cd /docker/security
openssl genrsa -out portainer.key 2048bw =buw======
openssl ecparam -genkey -name secp384r1 -out portainer.key

cat > portainer_cert.cnf << EOF 
[req]
distinguished_name = req_distinguished_name
prompt = no
[req_distinguished_name]
C = PL
ST = malopolske
L = Krakow
O = Docker
OU = IT
CN = docker-host.com
EOF
# generate certificate 
openssl req -new -x509 -sha256 -key portainer.key -out portainer.crt -days 3650 -config portainer_cert.cnf
# display on screen
openssl x509 -text -noout -in portainer.crt

# just in case restart docker daemon
sudo systemctl restart docker
sudo systemctl status docker 
# run portainer container with ssl 
docker run -d -p 443:9000 --name portainer_console --restart always \
-v /docker/security:/certs \
-v /docker/docker_data:/data \
-v /var/run/docker.sock:/var/run/docker.sock \
portainer/portainer \
--ssl --sslcert /certs/portainer.crt --sslkey /certs/portainer.key

#docker run -d -p 80:8080 --name jenkins --restart always jenkins:local
