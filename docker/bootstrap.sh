#!/usr/bin/env bash
# check if a go version is set

ls /usr/local/share/ca-certificates/PCAcert.crt > /dev/null 2>&1
CERT_INSTALLED=$?

if [ $CERT_INSTALLED -eq 0 ]; then
    echo "Cert Already Installed"
else
    echo "Installing Cert"
    sudo cp /vagrant/PCA*.crt /usr/local/share/ca-certificates
    sudo update-ca-certificates 
fi

sudo apt-get update
docker ps > /dev/null 2>&1
DOCKER_INSTALLED=$?

if [ $DOCKER_INSTALLED -eq 0 ]; then
    echo "Docker Already Installed"
else
    echo ">>> Installing docker"

    sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
    sudo apt-get update
    sudo apt-get install -y docker-ce
    echo ">>> Adding vagrant user to docker group"
    sudo usermod -aG docker vagrant
fi
