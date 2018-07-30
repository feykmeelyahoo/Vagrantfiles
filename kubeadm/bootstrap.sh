#!/usr/bin/env bash
# check if a go version is set

sudo apt-get update
sudo apt-get upgrade -y

docker ps > /dev/null 2>&1
DOCKER_INSTALLED=$?

if [ $DOCKER_INSTALLED -eq 0 ]; then
    echo "Docker Already Installed"
else
    echo ">>> Installing docker"
    sudo swapoff -a
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

kubeadm > /dev/null 2>&1
KUBEADM_INSTALLED=$?

if [ $KUBEADM_INSTALLED -eq 0 ]; then
    echo "Kubeadm Already Installed"
else
    echo ">>> Installing Kubeadm"
    sudo apt-get update && apt-get install -y apt-transport-https curl
    sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

    sudo bash -c 'cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF'
    sudo apt-get update
    sudo apt-get install -y kubelet kubeadm kubectl
    sudo apt-mark hold kubelet kubeadm kubectl

    sudo shutdown now -r
fi
